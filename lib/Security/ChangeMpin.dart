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

  @override
  Widget build(BuildContext context) {
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
                          child: TextField(
                            controller: old,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your old pin'),
                            onSubmitted: (String str) {},
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
                          child: TextField(
                            obscureText: true,
                            controller: newp,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your new pin'),
                            onSubmitted: (String str) {},
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
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your new pin again'),
                          onSubmitted: (String str) {},
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(15),
                        onPressed: () {
                          CheckPassword();
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
                    ],
                  )),
            );
          }),
    );
  }
}
