import 'dart:async';
import 'dart:convert';



import 'package:finance_app/mPinPage.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


SharedPreferences preferences;
String id = "";
var pin ;



 class SetPin extends StatefulWidget {

   final String currentUserID;
   SetPin({Key key, @required this.currentUserID}) : super(key: key);
  @override
  _SetPinState createState() => _SetPinState(currentUserID: currentUserID);
}

 class _SetPinState extends State<SetPin> {
   String currentUserID;
   _SetPinState({@required this.currentUserID});

   var val;
   String validatePin1(String value) {
     if (value.isEmpty) {
       _loading = false;
       return 'Pin must not be blank';
     } else if (value.length > 4) {
       _loading = false;
       return 'Pin must be of 4 digits';
     } else
       return null;
   }

   final _formKey = GlobalKey<FormState>();
   bool _autoValidate = false;
   void _validateInputs() {
     if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
       _formKey.currentState.save();
       setMPin();
     } else {
//    If all data are not valid then start auto validation.
       setState(() {
         _autoValidate = true;
       });
     }
   }

   TextEditingController pinCon;

   final _pinController = TextEditingController();


   Future setMPin() async {

     String pin = _pinController.text;
     var url = 'http://sanjayagarwal.in/Finance App/MpinInsert.php';
     print("****************************************************");
     print(pin);
     print(currentUserID);
     print("****************************************************");
     final response = await http.post(
       url,
       body: jsonEncode(<String, String>{
         "UserID": currentUserID,
         "mPin": pin
       }),
     );
     var message = jsonDecode(response.body);
     if (message["message"] == "Successful") {
       print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
       print(currentUserID);
       Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) => PassCodeScreen(
                 currentUserID: currentUserID,
               )));
       print(currentUserID);
     } else {
       print(message["message"]);
     }
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



   bool _isHidden = true;

   void _toggleVisibility() {
     setState(() {
       _isHidden = !_isHidden;
     });
   }

   bool _isHidden2 = true;

   void _toggleVisibility2() {
     setState(() {
       _isHidden2 = !_isHidden2;
     });
   }
   bool _loading = false;
   @override
   Widget build(BuildContext context) {
     var width = MediaQuery
         .of(context)
         .size
         .width;
     var height = MediaQuery
         .of(context)
         .size
         .height;
     return Scaffold(
       body: LayoutBuilder(
           builder: (BuildContext context, BoxConstraints viewportConstraints) {
             return SingleChildScrollView(
               child: ConstrainedBox(
                 constraints: BoxConstraints(
                   minHeight: viewportConstraints.maxHeight,
                 ),
                 child: Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.symmetric(horizontal: 24),
                   color: Colors.white,
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.all(60),
                         child: Container(
                           child: Text(
                             'Security Pin',
                             style: TextStyle(
                                 fontSize: width * 0.1,
                                 color: Color(0xff373D3F)),
                           ),
                         ),
                       ),
                       Form(
                           key: _formKey,
                           autovalidate: _autoValidate,
                           child: SingleChildScrollView(
                             child: Column(
                               children: <Widget>[
                                 TextFormField(
                                   obscureText: _isHidden,
                                   keyboardType: TextInputType.number,
                                   decoration: InputDecoration(
                                       hintText: ("Enter Pin"),
                                       border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(
                                             0.5),
                                       ),

                                       suffixIcon: IconButton(
                                         onPressed: _toggleVisibility,
                                         icon: Icon(Icons.visibility_off),
                                       )
                                   ),
                                   validator: validatePin1,
                                   // validator: (String value1) {
                                   //   val = value1;
                                   //   //Fluttertoast.showToast(msg: val);
                                   //   if (value1.isEmpty) {
                                   //     return 'Please enter a security pin';
                                   //   }
                                   //   if (value1.length > 4) {
                                   //     return 'Pin must contain four digits only. ';
                                   //   }
                                   //   return null;
                                   // },
                                   controller: _pinController,
                                   onSaved: (value) {},
                                 ),
                                 SizedBox(
                                   height: 20,
                                 ),
                                 TextFormField(
                                   obscureText: _isHidden2,
                                   keyboardType: TextInputType.number,
                                   decoration: InputDecoration(
                                       hintText: ("Re-enter Pin"),
                                       border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(
                                             0.5),
                                       ),
                                       suffixIcon: IconButton(
                                         onPressed: _toggleVisibility2,
                                         icon: Icon(Icons.visibility_off),
                                       )
                                   ),
                                   validator: (val) {
                                     if (val.isEmpty)
                                       return 'Pin field cannot be empty';
                                     if (val != _pinController.text) return 'Pins do not match';
                                     return null;
                                   },
                                   onSaved: (value) {},
                                 ),
                               ],
                             ),
                           )
                       ),
                       SizedBox(
                         height: 15,
                       ),
                       RaisedButton(
                         onPressed: (){
                           setState(() {
                             _loading = true;
                           });
                           _validateInputs();
                         },
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                             'SET PIN',
                             style: TextStyle(
                                 color: Color(0xff373D3F),
                                 fontSize: width * 0.05),
                           ),
                         ),
                         color: Color(0xff63E2E0),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30),
                         ),
                       ),


                     ],
                   ),
                 ),
               ),
             );
           }),
     );
   }
Future<Null> printPin(){
     Fluttertoast.showToast(msg: pin);
}



 }





























