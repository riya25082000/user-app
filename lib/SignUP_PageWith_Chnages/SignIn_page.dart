// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finance_app/HomePage.dart';
// import 'package:finance_app/HomePage/homepage.dart';
// import 'package:finance_app/forget_password.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:string_validator/string_validator.dart' as st_validator;
// import 'Widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:finance_app/authentication.dart';
// import 'SignUp_page.dart';
//
// import 'SignUp_page.dart';
//
// class LoginPage1 extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage1> {
//   //final _formKey2 = GlobalKey<FormState>();
//   String currentUserID;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   Future userLogin() async {
//     String email = emailController.text;
//     String password = passwordController.text;
//     var url = 'http://sanjayagarwal.in/Finance App/signin2.php';
//     final response = await http.post(
//       url,
//       body: jsonEncode(<String, String>{
//         "email": email,
//         "Password": password,
//       }),
//     );
//     var message = jsonDecode(response.body);
//     if (message == "Login Matched") {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => HomePage(currentUserID: currentUserID,)));
//     } else {
//       print(message);
//     }
//   }
//
//   bool _isHidden = true;
//
//   void _toggleVisibility() {
//     setState(() {
//       _isHidden = !_isHidden;
//     });
//   }
//
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   SharedPreferences preferences;
//
//   bool isLoggedIn = false;
//   bool isLoading = false;
//   FirebaseUser currentUser;
//
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   var _isProcessing;
//
//   @override
//   void initState() {
//     super.initState();
//     _isProcessing = false;
//
//     isSignedIn();
//   }
//
//   void isSignedIn() async {
//     this.setState(() {
//       isLoggedIn = true;
//     });
//
//     preferences = await SharedPreferences.getInstance();
//
//     isLoggedIn = await googleSignIn.isSignedIn();
//
//     if (isLoggedIn) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   HomeScreen(currentUserId: preferences.getString("id"))));
//     }
//     this.setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   final _formKey2 = GlobalKey<FormState>();
//
//   Map<String, String> _authData = {'email': '', 'password': ''};
//
//   void validateAndSave() {
//     final FormState form = _formKey2.currentState;
//     if (form.validate()) {
//       print('Form is valid');
//     } else {
//       print('Form is invalid');
//     }
//   }
//
//   Future<void> _submit() async {
//     if (!_formKey2.currentState.validate()) {
//       return;
//     }
//     _formKey2.currentState.save();
//
//     try {
//       await Provider.of<Authentication>(context, listen: false)
//           .logIn(_authData['email'], _authData['password']);
//
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (BuildContext context) => HomeScreen(currentUserId: currentUserID,)));
//     } catch (error) {
//       var errorMessage = 'Authentication Failed. Please try again';
//       _showErrorDailog(errorMessage);
//     }
//   }
//
//   void _showErrorDailog(String msg) {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//               title: Text('An Error Occurred'),
//               content: Text(msg),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Okay'),
//                   onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },
//                 )
//               ],
//             ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints viewportConstraints) {
//         return SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: viewportConstraints.maxHeight,
//             ),
//             child: Container(
//               height: height,
//               child: Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(60),
//                       child: Container(
//                         child: Text(
//                           'LOGIN',
//                           style: TextStyle(
//                               fontSize: width * 0.1, color: Color(0xff373D3F)),
//                         ),
//                       ),
//                     ),
//                     Form(
//                       key: _formKey2,
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             decoration: textfield("Phone Number/ Email"),
//                             validator: (value1) {
//                               if (value1.isEmpty) {
//                                 return 'Please enter an email address';
//                               }
// //                              if (st_validator.isEmail(value1)) {
// //                                return 'Enter a valid email address';
// //                              }
// //                              if (value1.split('@').length != 2) {
// //                                return 'Enter a valid email address';
// //                              }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _authData['email'] = value;
//                             },
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             obscureText: _isHidden,
//                             decoration: InputDecoration(
//                                 hintText: 'Password',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(0.5),
//                                 ),
//                                 suffixIcon: IconButton(
//                                   onPressed: _toggleVisibility,
//                                   icon: Icon(Icons.visibility_off),
//                                 )),
//                             validator: (value1) {
//                               if (value1.isEmpty) {
//                                 return 'Please enter a password';
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _authData['password'] = value;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                         ForgetPassPage()));
//                           },
//                           child: Text('Forgot Password?',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: width * 0.04,
//                                   color: Color(0xff373D3F))),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     RaisedButton(
//                       onPressed: () {
//                         _submit();
//                         validateAndSave();
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'LOGIN',
//                           style: TextStyle(
//                               fontSize: width * 0.05, color: Color(0xff373D3F)),
//                         ),
//                       ),
//                       color: Color(0xff63E2E0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           'New User? ',
//                           style: TextStyle(
//                               color: Color(0xff373D3F), fontSize: width * 0.04),
//                         ),
//                         GestureDetector(
//                           //onTap: () {
//                           //   Navigator.pushReplacement(
//                           //       context,
//                           //       MaterialPageRoute(
//                           //           builder: (BuildContext context) =>
//                           //               SignUp()));
//                           // },
//                           child: Text(
//                             'Sign Up',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff63E2E0),
//                                 fontSize: width * 0.04),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: Divider(
//                             color: Color(0xff616161),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "OR",
//                             style: TextStyle(
//                               color: Color(0xff373D3F),
//                               fontSize: width * 0.04,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Divider(
//                             color: Color(0xff616161),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       width: width * 0.7,
//                       child: RaisedButton(
//                         color: Colors.white,
//                         onPressed: controlSignIn,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             Image.asset('assets/images/google.jpg',
//                                 height: 50, width: 40),
//                             Text(
//                               'Login with Google',
//                               style: TextStyle(
//                                 color: Color(0xff373D3F),
//                                 fontSize: width * 0.04,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   Future<Null> controlSignIn() async {
//     preferences = await SharedPreferences.getInstance();
//     this.setState(() {
//       isLoading = true;
//     });
//
//     GoogleSignInAccount googleUser = await googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuthentication =
//         await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//         idToken: googleAuthentication.idToken,
//         accessToken: googleAuthentication.accessToken);
//
//     FirebaseUser firebaseUser =
//         (await firebaseAuth.signInWithCredential(credential)).user;
//
// // Sign in success
//
//     if (firebaseUser != null) {
//       // if already signed up
//
//       final QuerySnapshot resultQuery = await Firestore.instance
//           .collection("users")
//           .where("id", isEqualTo: firebaseUser.uid)
//           .getDocuments();
//       final List<DocumentSnapshot> documentSnapshots = resultQuery.documents;
//
//       // if user is new
//
//       if (documentSnapshots.length == 0) {
//         Firestore.instance
//             .collection("users")
//             .document(firebaseUser.uid)
//             .setData({
//           "username": firebaseUser.displayName,
//           "photoUrl": firebaseUser.photoUrl,
//           "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
//         });
//
//         // write data locally
//
//         currentUser = firebaseUser;
//         await preferences.setString("id", currentUser.uid);
//         await preferences.setString("username", currentUser.displayName);
//         await preferences.setString("photoUrl", currentUser.photoUrl);
//       } else {
//         //retrieve data from firebase
//         currentUser = firebaseUser;
//         await preferences.setString("id", documentSnapshots[0]["id"]);
//         await preferences.setString(
//             "username", documentSnapshots[0]["username"]);
//         await preferences.setString(
//             "photoUrl", documentSnapshots[0]["photoUrl"]);
//       }
//
//       Fluttertoast.showToast(msg: "Sign In Success !!");
//       this.setState(() {
//         isLoading = false;
//       });
//
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   HomeScreen(currentUserId: firebaseUser.uid)));
//     }
//
// // sign in failed
//
//     else {
//       Fluttertoast.showToast(msg: "Please try again !!");
//       this.setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }
