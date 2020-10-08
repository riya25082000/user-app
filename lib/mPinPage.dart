import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/HomePage.dart';
import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/RewardHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lock_screen/flutter_lock_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

SharedPreferences preferences;
String id = "";
var pin;



class PassCodeScreen extends StatefulWidget {
  final String currentUserID;
  PassCodeScreen({Key key, @required this.currentUserID}) : super(key: key);

  @override
  _PassCodeScreenState createState() => new _PassCodeScreenState();
}

class _PassCodeScreenState extends State<PassCodeScreen> {
  SharedPreferences preferences;
  String currentUserID;
  _PassCodeScreenState({@required this.currentUserID});

  @override
  void initState() {
    super.initState();
    getPin();
    getTouchID();
  }
var  enabled;
  Future getPin() async {
    var url = 'http://sanjayagarwal.in/Finance App/MpinDetail.php';
    currentUserID='8384500';
    print(currentUserID);
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
     message = await jsonDecode(response.body);
    print("****************************************");
    print(currentUserID);
    print(message);
    print("****************************************");
  }

  Future getTouchID() async {
    var url = 'http://sanjayagarwal.in/Finance App/TouchIDDetail.php';
    //currentUserID='8384500';
    print(currentUserID);
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message1 = await jsonDecode(response.body);
    print("****************************************");
    print(currentUserID);
  //  print(message1);
    print("****************************************");
    setState(() {
      enabled = message1;
      print(enabled);
    });
  }
  var message;


  bool isFingerprint = false;

  Future<Null> biometrics() async {
    final LocalAuthentication auth = new LocalAuthentication();
    bool authenticated = false;
    if(enabled=='0') {
      try {
        authenticated = await auth.authenticateWithBiometrics(
            localizedReason: 'Scan your fingerprint to authenticate',
            useErrorDialogs: true,
            stickyAuth: false);
      } on PlatformException catch (e) {
        print(e);
      }
      if (!mounted) return;
      if (authenticated) {
        setState(() {
          isFingerprint = true;
        });
      }
    }
    else print(enabled);
  }

  @override
  Widget build(BuildContext context) {



    return LockScreen(
        title: "Security Pin ",
        passLength: 4,
        bgImage: "assets/images/lock.jpg",
        fingerPrintImage: "assets/images/fingerprint.png",
        showFingerPass: true,
        fingerFunction: biometrics,
        fingerVerify: isFingerprint,
        borderColor: Colors.white,
        showWrongPassDialog: true,
        wrongPassContent: "Wrong pass please try again.",
        wrongPassTitle: "Opps!",
        wrongPassCancelButtonText: "Cancel",
        passCodeVerify: (List<int> passcode) async {
          List<int> myPass =
          [int.parse(message[0]),
            int.parse(message[1]),
            int.parse(message[2]),
            int.parse(message[3]) ];
          print(myPass);
          for (int i = 0; i < myPass.length; i++) {
            if (passcode[i] != myPass[i]) {
              print(passcode);
              return false;
            }
          }
          return true;
        },
        onSuccess: () {

          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) {
            return HomePage(
              currentUserID: currentUserID,
            );
          }));

        });
  }
}


//import 'package:finance_app/HomePage.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_lock_screen/flutter_lock_screen.dart';
//
//
//class PassCodeScreen extends StatefulWidget {
//
//  final String currentUserId;
//  PassCodeScreen({Key key, @required this.currentUserId}) : super(key: key);
//  @override
//  State createState() => _PassCodeScreen();
//
//}
//
//class _PassCodeScreen extends State<PassCodeScreen>
//{
//  @override
//  Widget build(BuildContext context) {
//
//    var myPass = [1,2,3,4];
//    return LockScreen(
//      title: "Security Pin",
//      passLength: myPass.length,
//      bgImage: 'assets/images/lock.jpg',
//      showFingerPass: false,
//      fingerFunction: () => print("pin"),
//      borderColor: Colors.white,
//      showWrongPassDialog: true,
//      wrongPassContent: "Wrong pin please try again",
//      wrongPassTitle: "Error !!",
//      wrongPassCancelButtonText: "Cancel",
//      passCodeVerify: (List<int> passcode) async{
//        for(int i=0;i<myPass.length;i++)
//          {
//            if(passcode[i]!=myPass[i])
//              {
//                return false;
//              }
//          }
//        return true;
//      },
//      onSuccess: (){
//        Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//                builder: (BuildContext context) =>
//                    HomeScreen()));
//
//      });
//
//
//  }
//
//}
//
////class _PassCodeScreenState extends State<PassCodeScreen>
////{
////
////}

// import 'package:flutter/material.dart';
// import 'Fingerprint.dart';

// class MPinPage extends StatefulWidget {
//   @override
//   _MPinPageState createState() => _MPinPageState();
// }
// String output = '';
// class _MPinPageState extends State<MPinPage> {

//   _appendToOutput(value) {
//     if (this.mounted) {
//       this.setState((){
//         output = output == '' ? value.toString() : output + value.toString();
//       });
//     }
//   }
//   _removeFromOutput() {
//     if (this.mounted) {
//       this.setState(() {
//         output = output.substring(0, output.length-1);
//       });
//     }
//   }
//   backButton() {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           RaisedButton(
//             onPressed: () {
//               _removeFromOutput();
//             },
//             color: Color(0xff63E2E0),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
//               child: new Icon(Icons.backspace,color: Color(0xff373D3F),),
//             ),
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40)),
//           ),
//         ]
//     );
//   }
//   numericInputButton(value) {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           RaisedButton(
//             onPressed: () {
//               _appendToOutput(value);
//               print(output);
//             },
//             color: Color(0xff63E2E0),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 value.toString(),
//                 style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),
//               ),
//             ),
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40)),
//           ),
//         ]
//     );
//   }
//   bool pinValidity = true;
//   void checkPin(){
//     //Function to check Pin
//     setState(() {
//       pinValidity = false;
//       output = '';

//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     Text warningBuilder(){
//       if(!pinValidity){
//         return Text('Invalid mPin! Please Retry',
//           style: TextStyle(color: Colors.redAccent));
//       }
//       else{
//       return Text('');
//       }
//     }
//     Row spaceBuilder(){
//       if(output.length==0){
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff63E2E0)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),)
//           ],
//         );
//       }
//       else if(output.length==1){
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff63E2E0)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),)
//           ],
//         );
//       }
//       else if(output.length==2){
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff63E2E0)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),)
//           ],
//         );
//       }
//       else if(output.length==3){
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('__',
//               style: TextStyle(fontSize: 25, color: Color(0xff63E2E0)),)
//           ],
//         );
//       }
//       else if(output.length==4){
//         checkPin();
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),),
//             Text('*',
//               style: TextStyle(fontSize: 25, color: Color(0xff373D3F)),)
//           ],
//         );
//       }

//     }
//     double tileHeight = MediaQuery.of(context).size.height;
//     double tileWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text('Enter mPin to unlock',
//                     style: TextStyle(fontSize: 25, color: Color(0xff373D3F),fontWeight: FontWeight.w500),),
//                   SizedBox(height: 35,),
//                   spaceBuilder(),
//                   SizedBox(height: 20,),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: warningBuilder(),
//                   ),

//                   SizedBox(height: 20,),
//                   Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row (
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               numericInputButton(1),
//                               numericInputButton(2),
//                               numericInputButton(3),
//                             ]
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row (
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               numericInputButton(4),
//                               numericInputButton(5),
//                               numericInputButton(6),
//                             ]
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row (
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             numericInputButton(7),
//                             numericInputButton(8),
//                             numericInputButton(9),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row (
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               numericInputButton(0),
//                               backButton()
//                             ]
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5,),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: GestureDetector(
//                         onTap: () {

//                         },
//                         child: Text(
//                           'Forgot Pin',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xff63E2E0),
//                               fontSize: tileWidth * 0.06),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Divider(
//                           color: Color(0xff616161),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "OR",
//                           style: TextStyle(
//                             color: Color(0xff373D3F),
//                             fontSize: tileWidth * 0.04,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           color: Color(0xff616161),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   RaisedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   fingerPrint()));

//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Use Fingerprint',
//                         style: TextStyle(
//                             fontSize: tileWidth * 0.05, color: Color(0xff373D3F)),
//                       ),
//                     ),
//                     color: Color(0xff63E2E0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//         ),
//       ),
//     );
//   }
// }
