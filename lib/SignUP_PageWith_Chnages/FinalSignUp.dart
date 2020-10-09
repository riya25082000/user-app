import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/SignUP_PageWith_Chnages/Working_signin.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../setPin.dart';
import 'Widgets.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email, name, mobile, password, password2, uid, promo;
  Future UserInsert() async {
    int otp;
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/UserSignUp.php';
    // print("****************************************************");
    // print(
    //     "${nameController.text} ** ${emailController.text}** ${phoneController.text}");
    // print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'Name': name,
        'Email': email,
        'Mobile': mobile,
        'Password': password
      }),
    );
    var message1 = jsonDecode(response1.body);
    print("#####################");
    print(message1);
    print("#####################");
    if (message1 != null) {
      setState(() {
        uid = message1.toString();
      });
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
                    UserVerify(otp);
                  },
                ),
              ],
            );
          });
    } else {
      print(message1);
    }
  }

  Future UserVerify(int pincode) async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/RetrieveOtp.php';

    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'UserID': uid,
      }),
    );
    var message1 = jsonDecode(response1.body);
    print("****************************************************");
    print("otp");
    print(message1[0]["OTP"]);
    print("****************************************************");
    if (pincode == int.parse(message1[0]["OTP"])) {
      var url2 =
          'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/VerifyUser.php';
      print("****************************************************");
      print("verify user");
      print(uid);
      print("$email** $password** $mobile");
      print("****************************************************");
      final response2 = await http.post(
        url2,
        body: jsonEncode(<String, String>{
          'UserID': uid,
          'Email': email,
          'Mobile': mobile,
          'Password': password,
        }),
      );
      var message2 = jsonDecode(response2.body);
      print(message2);
      if (message2 == "Successful Insertion") {
        var url3 =
            'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/UserDetailsAdd.php';
        // print("****************************************************");
        // print("inserted");
        // print(
        //     "${emailController.text} ** ${passwordController.text}** ${phoneController.text}");
        // print("****************************************************");
        final response3 = await http.post(
          url3,
          body: jsonEncode(<String, String>{
            'UserID': uid,
            'Name': name,
            'Email': email,
            'Mobile': mobile,
            'Promo': promo
          }),
        );
        var message3 = jsonDecode(response3.body);
        print(message3);
        if (message3 == "Successful Insertion") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SetPin(
                        currentUserID: uid,
                      )));
        } else {
          print(message3);
        }
      } else {
        print(message2);
      }
    } else {
      print(message1);
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

  TextEditingController p = TextEditingController();
  bool _loading = false;
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      _loading = false;
      return 'Email must not be blank';
    } else if (!regex.hasMatch(value)) {
      _loading = false;
      return 'Enter Valid Email';
    } else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.isEmpty) {
      _loading = false;
      return 'Mobile Number must not be blank';
    } else if (value.length != 10) {
      _loading = false;
      return 'Mobile Number must be of 10 digit';
    } else
      return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      _loading = false;
      return 'Name must not be blank';
    } else if (value.length < 3) {
      _loading = false;
      return 'Name must be of more than 2 characters';
    } else
      return null;
  }

  String validatePass1(String value) {
    if (value.isEmpty) {
      _loading = false;
      return 'Password must not be blank';
    } else if (value.length < 5) {
      _loading = false;
      return 'Password must be of at least 5 characters';
    } else
      return null;
  }

  String validatePass2(String value) {
    if (value.isEmpty) {
      _loading = false;
      return 'Password must not be blank';
    } else if (password2 != password) {
      _loading = false;
      return 'The two passwords do not match';
    } else
      return null;
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      UserInsert();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
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
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: textfield("Name"),
                          validator: validateName,
                          onSaved: (v1) {
                            name = v1;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: validateMobile,
                          onSaved: (v2) {
                            mobile = v2;
                          },
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
                          validator: validateEmail,
                          onSaved: (v3) {
                            email = v3;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: textfield("Email Address"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: p,
                          validator: validatePass1,
                          onSaved: (v4) {
                            password = v4;
                          },
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty)
                              return 'Password field cannot be empty';
                            if (val != p.text) return 'Passwords do not match';
                            return null;
                          },
                          onSaved: (v5) {
                            password2 = v5;
                          },
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
                              icon: _isHidden
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onSaved: (v6) {
                            promo = v6;
                          },
                          decoration: InputDecoration(
                            hintText: 'Promo Code',
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
                      setState(() {
                        _loading = true;
                      });
                      _validateInputs();
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
                  Align(
                    child: loadingIndicator,
                    alignment: FractionalOffset.center,
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
