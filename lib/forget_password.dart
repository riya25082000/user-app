import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassPage extends StatefulWidget {
  @override
  _ForgetPassPageState createState() => _ForgetPassPageState();
}
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
class _ForgetPassPageState extends State<ForgetPassPage> {

  bool linkSend = false;
  bool isEmail = false;
  String email = "", errorMessage = "";
  var _formKey = GlobalKey<FormState>();
  String error = "";
  String defineText(isEmail,linkSend){

    String finalStatement;
    if(linkSend == false){
      finalStatement = '';
    }
    else{
      if(isEmail){
        finalStatement = 'A link is sent to the above Email to change your password \n\*Please check your MailBox and Spams\*';
      }
      else{
        finalStatement = 'A link is sent to the above Phone No. to change your password \n\*Please check your SMS\*';
      }
    }
    return finalStatement;
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

  @override
  Widget build(BuildContext context) {
    double tileHeight = MediaQuery.of(context).size.height;
    double tileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: tileHeight/6,
                  width: tileWidth,
                  color: Colors.white,
                  child: Image.asset('assets/images/lock.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return "Please enter your email";
                      }
                      else {
                        email = value;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'Phone No. or Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                RaisedButton(
                  color: Color(0xff63E2E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Color(0xff373D3F),
                        fontSize: tileHeight/35,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                  onPressed: forgetPassword,
                ),
                SizedBox(height: 30,),
                if(linkSend)(
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't received link? ",
                        style: TextStyle(
                            color: Color(0xff373D3F), fontSize: tileWidth* 0.04),
                      ),
                      GestureDetector(
                        onTap: () {
                          try {
                            if (_formKey.currentState.validate()) {
                              FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: email)
                                  .then((value) =>
                                  print("Check your email box"));
                            }
                          }
                          catch(error)
                          {
                            Fluttertoast.showToast(msg: "Sign In Success !!");
                          }

                        },
                        child: Text(
                          'Resend Link',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff63E2E0),
                              fontSize: tileWidth * 0.04),
                        ),
                      ),
                    ],
                  )
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      defineText(isEmail, linkSend),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff373D3F), fontSize: tileWidth* 0.04),
                    ),
                  ),
                ),
                SizedBox(height: tileHeight/6,)

              ],
            ),
        ),
          ),

      ),
      ),
    );
  }
  Future<void> forgetPassword() async{



    try {
      if (_formKey.currentState.validate()) {
         dynamic result = FirebaseAuth.instance.sendPasswordResetEmail(
            email: email)
            .then((value) => print("Check your email box"));



         if (result.runtimeType == PlatformException) {
           error = "Error occurred. Please try again !!";
           _showErrorDailog(error);

//           if (result.message != null) {
//             setState(() {
//               error = "Error occurred. Please try again !!";
//             });
//           } else {
//             setState(() {
//               error = "Unknown Error";
//             });
//           }
         }
        //
      }

      setState(() {
        isEmail = true;
        linkSend= true;
      });
    }

    on PlatformException catch (error) {
      var errorMessage = 'Authentication Failed. Please try again !';
      _showErrorDailog(errorMessage);

    }

  }
}
