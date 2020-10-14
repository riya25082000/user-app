// import 'package:finance_app/main.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class HomeScreen extends StatefulWidget {
//   final String currentUserId;
//   HomeScreen({Key key, @required this.currentUserId}) : super(key: key);
//   @override
//   State createState() => HomeScreenState();
// }
//
// class HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton.icon(
//         onPressed: logoutUser,
//         icon: Icon(Icons.close),
//         label: Text("Sign Out"));
//   }
//
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   Future<Null> logoutUser() async {
//     await FirebaseAuth.instance.signOut();
//     await googleSignIn.disconnect();
//     await googleSignIn.signOut();
//
//     //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp() ), (Route<dynamic> route) => false);
//   }
// }
//
// class UserResult extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {}
// }
