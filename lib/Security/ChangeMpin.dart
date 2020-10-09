import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/setPin.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangeMpin extends StatefulWidget {
  String currentUserID;
  ChangeMpin({@required this.currentUserID});
  @override
  _ChangeMpinState createState() =>
      _ChangeMpinState(currentUserID: currentUserID);
}

class _ChangeMpinState extends State<ChangeMpin> {
  String currentUserID;
  _ChangeMpinState({@required this.currentUserID});
  TextEditingController old = TextEditingController();
  TextEditingController newp = TextEditingController();
  String oldpass;
  Future CheckPassword() async {
    oldpass = old.text;
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/checkOldPin.php';
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
            title: Text("Wrong pin"),
            content: Text("You have entered the wrong pin"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SetPin()));
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
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/ChangeUserPin.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
        "newp": newp.text,
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
            title: Text("Pin Update Successful"),
            content: Text("Your pin has been changed successfully."),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
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
      return 'Pin must not be blank';
    } else if (value.length > 4) {
      _loading = false;
      return 'Pin must be of 4 digits';
    } else
      return null;
  }

  String validatePass2(String value) {
    if (value.isEmpty) {
      _loading = false;
      return 'Pin must not be blank';
    } else if (value.length > 4) {
      _loading = false;
      return 'New Pin must be of 4 digits';
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
          'Change My Pin',
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
                        child: Text("Old Pin",
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

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your old password',
                              // suffixIcon: IconButton(
                              //   icon: _isHidden
                              //       ? Icon(Icons.visibility)
                              //       : Icon(Icons.visibility_off),
                              // ),
                            ),
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                        child: Text("New Pin",
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
                              //newpass = v2;
                            },
                            //obscureText: _isHidden2,
                            controller: newp,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your new pin',
                              // suffixIcon: IconButton(
                              //   onPressed: _toggleVisibility2,
                              //   icon: _isHidden2
                              //       ? Icon(Icons.visibility)
                              //       : Icon(Icons.visibility_off),
                              // ),
                            ),
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                        child: Text("Confirm New Pin",
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
                              return 'Pin cannot be empty';
                            if (val != newp.text) return 'Pins do not match';
                            return null;
                          },
                          //obscureText: _isHidden3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your new pin again',
                            // suffixIcon: IconButton(
                            //   onPressed: _toggleVisibility3,
                            //   icon: _isHidden3
                            //       ? Icon(Icons.visibility)
                            //       : Icon(Icons.visibility_off),
                            // ),
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
                          "Change Pin",
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
