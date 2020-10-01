import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart' as st_validator;
import 'Widgets.dart';
import 'Working_signin.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var val;
  String currentUserID;
  static final userNameRegExp = RegExp(r'^[A-Za-z0-9_.-]+$');

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;

  bool isLoggedIn = false;
  bool isLoading = false;
  FirebaseUser currentUser;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  var _isProcessing;

  Future<void> emailVerification() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String phone = _phoneController.text;
    String name = _usernameController.text;
    var url = 'http://sanjayagarwal.in/Finance App/Signup3.php';
    print("****************************************************");
    print(email);
    print("****************************************************");
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Email": email,
        "UserID": currentUserID,
        "Password": password,
        "Name": name,
        "Phone": phone
      }),
    );
    if (response.body.isNotEmpty) {
      var message = jsonDecode(response.body);
      if (message["message"] == "Successful Signup" &&
          message[0]['OTP'] == otp) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      currentUserID: currentUserID,
                    )));
      } else {
        print("****************************************************");
        print(message["message"]);
        print("****************************************************");
      }
    }
  }

  Future userSignup() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String phone = _phoneController.text;
    String name = _usernameController.text;
    var url = 'http://sanjayagarwal.in/Finance App/signup.php';
    print("****************************************************");
    print("$email,$password,$phone,$name");
    print("****************************************************");
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
        "name": name,
        "phone": phone
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

  @override
  void initState() {
    super.initState();
    _isProcessing = false;

    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoggedIn = true;
    });

    preferences = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();

    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(currentUserID: currentUserID)));
    }
    this.setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool confirmMobile = false;
  void checkMobileOTP(String otp) {
    setState(() {
      confirmMobile = true;
    });
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

  Map<String, String> _authData = {'email': '', 'password': ''};
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Authentication>(context, listen: false)
          .signUp(_authData['email'], _authData['password']);
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again';
      _showErrorDailog(errorMessage);
    }
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 60),
          verificationCompleted: (AuthCredential credential) async {
            Navigator.of(context).pop();

            AuthResult result = await _auth.signInWithCredential(credential);

            FirebaseUser user = result.user;

            if (user != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage(currentUserID: currentUserID)));
            } else {
              print("Error");
            }

            //This callback would gets called when verification is done auto maticlly
          },
          verificationFailed: (AuthException exception) {
            print(exception);
          },
          codeSent: (String verificationId, [int forceResendingToken]) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Give the code?"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _codeController,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Confirm"),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () async {
                          final code = _codeController.text.trim();
                          AuthCredential credential =
                              PhoneAuthProvider.getCredential(
                                  verificationId: verificationId,
                                  smsCode: code);

                          AuthResult result =
                              await _auth.signInWithCredential(credential);

                          FirebaseUser user = result.user;

                          if (user != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          currentUserID: currentUserID,
                                        )));
                          } else {
                            print("Error");
                          }
                        },
                      )
                    ],
                  );
                });
          },
          codeAutoRetrievalTimeout: null);
    } catch (error) {
      throw error;
    }
  }

  void _showErrorDailog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occurred'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  String otp = "";
  void toggleMobile() {
    if (confirmMobile == false) {
      setState(() {
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
                        otp = pin;
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
                      'Resend OTP',
                      style: TextStyle(
                        color: Color(0xff373D3F),
                      ),
                    ),
                    onPressed: () {
                      emailVerification();
                    },
                  ),
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
                      checkMobileOTP('otp');
                    },
                  ),
                  FlatButton(
                    color: Color(0xff63E2E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Color(0xff373D3F),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: textfield("Username"),
                          controller: _usernameController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a username';
                            }
                            if (!userNameRegExp.hasMatch(value)) {
                              return 'Only Alphanumerics, underscore or period, allowed';
                            }
                            if (value[0] == value[0].toUpperCase()) {
                              return 'First letter should not be uppercase in username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          decoration: textfield("Phone Number"),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a PhoneNumber';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textfield("Email (Optional)"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            if (st_validator.isEmail(value)) {
                              return 'Enter a valid email address';
                            }
                            if (value.split('@').length != 2) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                            String email = value;
                            print(
                                "****************************************************");
                            print(email);
                            print(
                                "****************************************************");
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _passwordController,
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
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
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
                          validator: (String value) {
                            if (val != value) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      userSignup();
                      if (_emailController.text.isNotEmpty) {
                        toggleMobile();
                      }
//                         setState(() {
//                           toggleMobile();
//                           if (_formKey.currentState.validate()) ;
//                         });
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
                      onPressed: controlSignIn,
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

  Future<Null> controlSignIn() async {
    preferences = await SharedPreferences.getInstance();
    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken);

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

// Sign in success

    if (firebaseUser != null) {
      // if already signed up

      final QuerySnapshot resultQuery = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documentSnapshots = resultQuery.documents;

      // if user is new

      if (documentSnapshots.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "username": firebaseUser.displayName,
          "photoUrl": firebaseUser.photoUrl,
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
        });

        // write data locally

        currentUser = firebaseUser;
        await preferences.setString("id", currentUser.uid);
        await preferences.setString("username", currentUser.displayName);
        await preferences.setString("photoUrl", currentUser.photoUrl);
      } else {
        //retrieve data from firebase
        currentUser = firebaseUser;
        await preferences.setString("id", documentSnapshots[0]["id"]);
        await preferences.setString(
            "username", documentSnapshots[0]["username"]);
        await preferences.setString(
            "photoUrl", documentSnapshots[0]["photoUrl"]);
      }

      Fluttertoast.showToast(msg: "Sign In Success !!");
      this.setState(() {
        isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(currentUserID: currentUserID)));
    }

// sign in failed

    else {
      Fluttertoast.showToast(msg: "Please try again !!");
      this.setState(() {
        isLoading = false;
      });
    }
  }
}
