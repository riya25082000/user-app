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
  TextEditingController old = TextEditingController();
  TextEditingController newp = TextEditingController();

  Future PasswordUpdate() async {
    print("********************************************************");
    print("");
    print("********************************************************");
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/ChangeUserPassword.php';
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print(message1["message"]);
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
                      child: TextField(
                        controller: old,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your old password'),
                        onSubmitted: (String str) {},
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
                      child: TextField(
                        controller: newp,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your new password'),
                        onSubmitted: (String str) {},
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
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your new password again'),
                      onSubmitted: (String str) {},
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      PasswordUpdate();
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
                ],
              )),
        );
      }),
    );
  }
}
