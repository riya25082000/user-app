import 'dart:async';

import 'package:finance_app/HomePage/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart' as st_validator;
import 'FinalSignUp.dart';
import 'Widgets.dart';
import 'package:http/http.dart' as http;
import 'package:finance_app/forget_password.dart';
import 'dart:convert';
import 'signup2.dart';

class LoginPage extends StatefulWidget {
  String currentUserID;
  LoginPage({@required this.currentUserID});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String currentUserID;
  _LoginPageState({@required this.currentUserID});
  var val;
  bool _isHidden = true;

  get handleTimeout => handleTimeOut();

  void handleTimeOut() {}

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  bool _loading = false;
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      _loading = false;
      return 'Please enter a valid email or phone number';
    } else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      _loading = false;
      return 'Please enter a password';
    } else if (value.length < 5) {
      _loading = false;
      return 'Password must be greater than 5 characters';
    } else {
      return null;
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      userLogin();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String email, password;
  Future userLogin() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/UserLogin.php';
    print(email);
    print(password);
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Value": email,
        "Password": password,
      }),
    );
    var message = jsonDecode(response.body);

    print(message);
    if (message == "Invalid Username or Password Please Try Again") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Email/Password"),
            content: Text("Username or Password is invalid. Please try again"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                },
                child: Text("Ok"),
              )
            ],
          );
        },
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userid', message.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    currentUserID: message.toString(),
                  )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_initialiseTimer();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _loading
        ? new Container(
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                    child: new CircularProgressIndicator(
                  backgroundColor: Color(0xff63E2E0),
                ))),
          )
        : new Container();
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
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: textfield("Phone Number/ Email"),
                            validator: validateEmail,
                            onSaved: (v1) {
                              email = v1;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
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
                                  icon: _isHidden
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                )),
                            validator: validatePassword,
                            onSaved: (value) {
                              password = value;
                            },
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
                                        ForgetPassPage(
                                          currentUserID: currentUserID,
                                        )));
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
                      onPressed: () {
                        setState(() {
                          _loading = true;
                        });
                        _validateInputs();
                      },
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Signup()));
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: FlatButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/google.jpg',
                                height: 50, width: 40),
                            SizedBox(
                              width: 10,
                            ),
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
                    Align(
                      child: loadingIndicator,
                      alignment: FractionalOffset.center,
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
