import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/HomePage.dart';
import 'package:finance_app/SignUP_PageWith_Chnages/Working_signin.dart';
import 'package:finance_app/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart' as st_validator;
import 'Widgets.dart';
import 'SignIn_page.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String currentUserID;
  var val;
  static final userNameRegExp = RegExp(r'^[A-Za-z0-9_.-]+$');
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();


  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;


  bool isLoggedIn = false;
  bool isLoading = false;
  FirebaseUser currentUser;


  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isProcessing;

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
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          HomeScreen(currentUserId: preferences.getString("id"))));
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
  void checkMobileOTP(String otp){
    setState(() {
      confirmMobile = true;
    });
  }
  bool _isHidden = true;

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  bool _isHidden2 = true;

  void _toggleVisibility2(){
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  Map<String, String> _authData= {
    'email' : '',
    'password' : ''

  };
  Future<void> _submit() async{
    if(!_formKey.currentState.validate())
    {
      return ;
    }
    _formKey.currentState.save();
    try{
      await  Provider.of<Authentication>(context, listen: false).
      signUp(_authData['email'],
          _authData['password']);

    }
    catch(error)
    {
      var errorMessage = 'Authentication Failed. Please try again';
      _showErrorDailog(errorMessage);
    }

  }

  Future<bool> loginUser(String phone, BuildContext context) async{
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
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomeScreen(currentUserId: currentUserID,)
              ));
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
                          AuthCredential credential = PhoneAuthProvider
                              .getCredential(
                              verificationId: verificationId, smsCode: code);

                          AuthResult result = await _auth.signInWithCredential(
                              credential);

                          FirebaseUser user = result.user;

                          if (user != null) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomeScreen(currentUserId: currentUserID,)
                            ));
                          } else {
                            print("Error");
                          }
                        },
                      )
                    ],
                  );
                }
            );
          },
          codeAutoRetrievalTimeout: null
      );
    }
    catch(error)
    {
      throw error;
    }
  }
  void _showErrorDailog(String msg)
  {
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
        )
    );
  }

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
                    'Enter the OTP',
                    style: TextStyle(
                      color: Color(0xff373D3F),
                    ),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 16,
                    style: TextStyle(
                        fontSize: 14
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    },
                  ),],
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
                      checkMobileOTP('otp');
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
                  height: height * 1.2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                keyboardType: TextInputType.number,
                                decoration: textfield("Phone Number"),
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
                                onSaved: (value)
                                {
                                  _authData['email']=value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                obscureText: _isHidden,
                                decoration:  InputDecoration(
                                    hintText: ' Password',
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
                                onSaved: (value)
                                {
                                  _authData['password']=value;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                obscureText: _isHidden2,
                                decoration:  InputDecoration(
                                    hintText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.5),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: _toggleVisibility2,
                                      icon: Icon(Icons.visibility_off),
                                    ),),
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
                            final phone = _phoneController.text.trim();

                            loginUser(phone, context);
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
                          height: 30,
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
                        Container(
                          width: width * 0.7,
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: controlSignIn,
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
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Row(
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

  Future<Null> controlSignIn() async {
    preferences = await SharedPreferences.getInstance();
    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuthentication = await googleUser
        .authentication;
    final AuthCredential credential = GoogleAuthProvider
        .getCredential(idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken);

    FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(
        credential)).user;

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
        Firestore.instance.collection("users")
            .document(firebaseUser.uid)
            .setData({

          "username": firebaseUser.displayName,
          "photoUrl": firebaseUser.photoUrl,
          "createdAt": DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
        });

        // write data locally

        currentUser = firebaseUser;
        await preferences.setString("id", currentUser.uid);
        await preferences.setString("username", currentUser.displayName);
        await preferences.setString("photoUrl", currentUser.photoUrl);
      }
      else {
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

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeScreen(currentUserId: firebaseUser.uid)));
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