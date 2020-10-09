import 'package:finance_app/SignUP_PageWith_Chnages/Working_signin.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  String currentUserID;
  ChangePassword({@required this.currentUserID});
  @override
  _ChangePasswordState createState() =>
      _ChangePasswordState(currentUserID: currentUserID);
}

class _ChangePasswordState extends State<ChangePassword> {
  String currentUserID;
  _ChangePasswordState({@required this.currentUserID});
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

  bool _isHidden3 = true;

  void _toggleVisibility3() {
    setState(() {
      _isHidden3 = !_isHidden3;
    });
  }

  TextEditingController old = TextEditingController();
  TextEditingController newp = TextEditingController();
  String oldpass, newpass;
  Future CheckPassword() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/CheckOldPassword.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message = jsonDecode(response.body);
    print("rihgrowhge");
    print(message);
    if (message == oldpass) {
      PasswordUpdate();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Wrong password"),
            content: Text("You have entered the wrong password"),
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
    }
  }

  Future PasswordUpdate() async {
    print("********************************************************");
    print("");
    print("********************************************************");
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/ChangeUserPassword.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
        "newp": newpass,
      }),
    );
    var message1 = jsonDecode(response1.body);
    print("********************************************************");
    print("ch1,$message1");
    print("********************************************************");
    if (message1 == "Successful Updation") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Password Update Successful"),
            content: Text("Your password has been changed successfully."),
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
      print(message1);
    }
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
    } else if (value.length < 5) {
      _loading = false;
      return 'New Password must be of at least 5 characters';
    } else
      return null;
  }

  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      CheckPassword();
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff63E2E0),
        title: Text(
          'Change My Password',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    color: Color(0xfffffff),
                    alignment: Alignment.centerLeft,
                    child: Text("Old Password",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff373D3F),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color(0xfffffff).withOpacity(0.9),
                      ),
                      child: TextFormField(
                        controller: old,
                        onSaved: (v1) {
                          oldpass = v1;
                        },
                        validator: validatePass1,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your old password',
                          suffixIcon: IconButton(
                            onPressed: _toggleVisibility,
                            icon: _isHidden
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    child: Text("New Password",
                        style: TextStyle(
                          color: Color(0xff373D3F),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color(0xfffffff).withOpacity(0.9),
                      ),
                      child: TextFormField(
                        validator: validatePass2,
                        onSaved: (v2) {
                          newpass = v2;
                        },
                        obscureText: _isHidden2,
                        controller: newp,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your new password',
                          suffixIcon: IconButton(
                            onPressed: _toggleVisibility2,
                            icon: _isHidden2
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    child: Text("Confirm New Password",
                        style: TextStyle(
                          color: Color(0xff373D3F),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color(0xfffffff).withOpacity(0.9),
                    ),
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty)
                          return 'Password field cannot be empty';
                        if (val != newp.text) return 'Passwords do not match';
                        return null;
                      },
                      obscureText: _isHidden3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your new password again',
                        suffixIcon: IconButton(
                          onPressed: _toggleVisibility3,
                          icon: _isHidden3
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      setState(() {
                        _loading = true;
                      });
                      _validateInputs();
                    },
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                          color: Color(0xff373D3F),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    elevation: 6.0,
                    color: Color(0xff63E2E0),
                  ),
                  Align(
                    child: loadingIndicator,
                    alignment: FractionalOffset.center,
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
