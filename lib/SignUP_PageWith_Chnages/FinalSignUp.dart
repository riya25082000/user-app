import 'dart:convert';

import 'package:finance_app/HomePage/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/SignUP_PageWith_Chnages/Working_signin.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'Widgets.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String currentUserID;
  int otp;
  Future<void> SignUpUser() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/UserSignUp.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Name": nameController.text,
        "Email": emailController.text,
        "Phone": phoneController.text,
        "Password": passwordController.text,
      }),
    );
    var message = jsonDecode(response.body);
    print("***********");
    print(message);
    if (message != null) {
      setState(() {
        currentUserID = message.toString();
        AddUserPassword(currentUserID);
      });
    } else {
      print(message);
    }
  }

  Future<void> AddUserPassword(String currentid) async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/VerifyUser.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentid,
        "Email": emailController.text,
        "Mobile": phoneController.text,
        "Password": passwordController.text,
      }),
    );
    var message = jsonDecode(response.body);
    print("***********");
    print(message);
    if (message != null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: Center(
                child: Text(
                  'Enter the OTP for Email Verification',
                  style: TextStyle(
                    color: Color(0xff373D3F),
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 16,
                    style: TextStyle(fontSize: 14),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                      otp = int.parse(pin);
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  color: Color(0xff63E2E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: Color(0xff373D3F),
                    ),
                  ),
                  onPressed: () {
                    UserDetailsAdd(currentid);
                  },
                ),
              ],
            );
          });
    } else {
      print(message);
    }
  }

  Future UserDetailsAdd(String cid) async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/UserDetailsAdd.php';
    print("****************************************************");
    print("");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'UserID': currentUserID,
        'Name': nameController.text,
        'Email': emailController.text,
        'Mobile': phoneController.text,
      }),
    );
    var message1 = jsonDecode(response1.body);
    print(message1);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    currentUserID: cid,
                  )));
    } else {
      print(message1);
    }
  }

  bool checked = false;

  void toggle(bool check) {
    if (checked == false) {
      setState(() {
        checked = true;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: Text(
                  'Enter the promo code',
                  style: TextStyle(
                    color: Color(0xff373D3F),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[TextField()],
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Color(0xff63E2E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Color(0xff373D3F),
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              );
            });
      });
    } else {
      setState(() {
        checked = false;
      });
    }
  }

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  bool _isHidden2 = true;
  final formKey = GlobalKey<FormState>();

  void _toggleVisibility2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              padding: EdgeInsets.symmetric(horizontal: 24),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 20),
                    child: Container(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Color(0xff373D3F), fontSize: width * 0.09),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: textfield("Name"),
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: textfield("Phone Number"),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textfield("Email (Optional)"),
                        ),
                        SizedBox(
                          height: 15,
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: _isHidden2,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Color(0xff373D3F)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff63E2E0),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.5),
                            ),
                            suffixIcon: IconButton(
                              onPressed: _toggleVisibility2,
                              icon: Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      SignUpUser();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Color(0xff373D3F), fontSize: width * 0.05),
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
                        'Already have an account? ',
                        style: TextStyle(
                            color: Color(0xff373D3F), fontSize: width * 0.04),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff63E2E0),
                              fontSize: width * 0.04),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                    height: 20,
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Got any promo/referral code? ',
                        style: TextStyle(
                          color: Color(0xff373D3F),
                        ),
                      ),
                      Checkbox(
                        value: checked,
                        onChanged: (bool value) {
                          toggle(value);
                        },
                        activeColor: Color(0xff616161),
                        checkColor: Colors.white,
                        tristate: false,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
