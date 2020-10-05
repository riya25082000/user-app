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
  String e, n, m, p, uid, promo;
  Future UserInsert() async {
    e = emailController.text;
    n = nameController.text;
    p = passwordController.text;
    m = phoneController.text;
    int otp;
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/UserSignUp.php';
    // print("****************************************************");
    // print(
    //     "${nameController.text} ** ${emailController.text}** ${phoneController.text}");
    // print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(
          <String, String>{'Name': n, 'Email': e, 'Mobile': m, 'Password': p}),
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
    e = emailController.text;
    m = phoneController.text;
    p = passwordController.text;
    n = nameController.text;
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
      e = emailController.text;
      p = passwordController.text;
      m = phoneController.text;
      promo = promoController.text;
      var url2 =
          'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/VerifyUser.php';
      print("****************************************************");
      print("verify user");
      print(uid);
      print(
          "${emailController.text} ** ${passwordController.text}** ${phoneController.text}");
      print("****************************************************");
      final response2 = await http.post(
        url2,
        body: jsonEncode(<String, String>{
          'UserID': uid,
          'Email': e,
          'Mobile': m,
          'Password': p,
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
            'Name': n,
            'Email': e,
            'Mobile': m,
            'Promo': promo
          }),
        );
        var message3 = jsonDecode(response3.body);
        print(message3);
        if (message3 == "Successful Insertion") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
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
  TextEditingController promoController = TextEditingController();
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: promoController,
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
                      UserInsert();
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
