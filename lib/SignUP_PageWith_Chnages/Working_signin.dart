import 'dart:async';

import 'package:finance_app/HomePage/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart' as st_validator;
import 'Widgets.dart';
import 'package:http/http.dart' as http;
import 'package:finance_app/forget_password.dart';
import 'dart:convert';
import 'signup2.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String currentUserID;
  var val;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isHidden = true;

  get handleTimeout => handleTimeOut();

  void handleTimeOut(){





}

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future userLogin() async {
    String email = emailController.text;
    String password = passwordController.text;
    var url = 'http://sanjayagarwal.in/Finance App/signinAdvisor.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "email": email,
        "Password": password,
      }),
    );
    var message = jsonDecode(response.body);
    if (message == "Login Matched") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    currentUserID: currentUserID,
                  )));
    } else {
      print(message);
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initialiseTimer();
  }

  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              height: height,
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
                          'LOGIN',
                          style: TextStyle(
                              fontSize: width * 0.1, color: Color(0xff373D3F)),
                        ),
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: textfield("Phone Number/ Email"),
                            validator: (value1) {
                              if (value1.isEmpty) {
                                return 'Please enter an email address';
                              }
                              if (st_validator.isEmail(value1)) {
                                return 'Enter a valid email address';
                              }
                              if (value1.split('@').length != 2) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintText: ' Password',
                                hintStyle: TextStyle(color: Color(0xff373D3F)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff63E2E0),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.5),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: _toggleVisibility,
                                  icon: Icon(Icons.visibility_off),
                                )),
                            validator: (String value) {
                              val = value;
                              if (value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 8) {
                                return 'Password must be greater than 8 alphabets';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ForgetPassPage()));
                          },
                          child: Text('Forgot Password?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.04,
                                  color: Color(0xff373D3F))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: userLogin,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: width * 0.05, color: Color(0xff373D3F)),
                        ),
                      ),
                      color: Color(0xff63E2E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New User? ',
                          style: TextStyle(
                              color: Color(0xff373D3F), fontSize: width * 0.04),
                        ),
                        GestureDetector(
                          onTap: () {


                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             SignUp()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff63E2E0),
                                fontSize: width * 0.04),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Color(0xff616161),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Color(0xff373D3F),
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xff616161),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: width * 0.7,
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.asset('assets/images/google.jpg',
                                height: 50, width: 40),
                            Text(
                              'Login with Google',
                              style: TextStyle(
                                color: Color(0xff373D3F),
                                fontSize: width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }






}
