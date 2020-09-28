import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/HomePage.dart';
import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/mPinPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

StreamSubscription<DocumentSnapshot> subscription;
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
   final _formKey = GlobalKey<FormState>();
   var val;
   FirebaseUser currentUser;


   TextEditingController pinCon;

   final _pinController = TextEditingController();
// //

   Future setMPin() async {

     String pin = _pinController.text;
     var url = 'http://sanjayagarwal.in/Finance App/MpinInsert.php';
     print("****************************************************");
     print(pin);
     print("****************************************************");
     final response = await http.post(
       url,
       body: jsonEncode(<String, String>{
         "UserID": currentUserID,
         "mPin": pin
       }),
     );
     var message = jsonDecode(response.body);
     if (message["message"] == "Successful Signup") {
       Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) => HomePage(
                 currentUserID: currentUserID,
               )));
     } else {
       print(message["message"]);
     }
   }

//   void readData() async{
//
//     preferences = await SharedPreferences.getInstance();
//     id = preferences.getString("id");
//   }




   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

   void validateAndSave() {
     final FormState form = _formKey.currentState;
     if (form.validate()) {
       print('Form is valid');
     } else {
       print('Form is invalid');
     }
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
                                   validator: (String value1) {
                                     val = value1;
                                     Fluttertoast.showToast(msg: val);
                                     if (value1.isEmpty) {
                                       return 'Please enter a security pin';
                                     }
                                     if (value1.length > 4) {
                                       return 'Pin must contain four digits only. ';
                                     }
                                     return null;
                                   },
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
                                   validator: (String value) {
                                     if (value != val) {
                                       return 'Pin does not match';
                                     }
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
                         onPressed: setMPin,
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


    Future <Null> savePinToFireStore() async{
      //id = preferences.getString("id");
    // String fileName = id;

    // StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
     Firestore.instance.collection('users').document(id).updateData({
       "pin": _pinController.text
     });

       Navigator.of(context).pushReplacement(
           new MaterialPageRoute(builder: (BuildContext context){
             return PassCodeScreen();
           })) ;




    }
 }





























