import 'package:finance_app/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailVerify extends StatefulWidget {
  final String currentUserID;
  String name, email, password;
  int mobile;
  EmailVerify(this.name, this.email, this.password, this.mobile,
      {@required this.currentUserID});
  @override
  _EmailVerifyState createState() => _EmailVerifyState(
      currentUserID: currentUserID,
      name: name,
      email: email,
      password: password,
      mobile: mobile);
}

class _EmailVerifyState extends State<EmailVerify> {
  String currentUserID;
  String name, email, password;
  int mobile;
  _EmailVerifyState(
      {this.name,
      this.email,
      this.password,
      this.mobile,
      @required this.currentUserID});
  int otp;
  Future<void> VerifyUser() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/VerifyUser.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "OTP": otp.toString(),
        "UserID": currentUserID,
        "Email": email,
        "Password": password,
        "Mobile": mobile.toString(),
      }),
    );
    var message = jsonDecode(response.body);
    print("***********");
    print(message);
    if (message != null) {
      UserDetailsAdd();
    } else {
      print(message);
    }
  }

  Future UserDetailsAdd() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/SignIn and SignUp/UserDetailsAdd.php';
    print("****************************************************");
    print("$name ** $email** $mobile");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'UserID': currentUserID,
        'Name': name,
        'Email': email,
        'Mobile': mobile.toString(),
      }),
    );
    var message1 = jsonDecode(response1.body);
    print(message1);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    currentUserID: currentUserID,
                  )));
    } else {
      print(message1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff373D3F),
        ),
        backgroundColor: Color(0xff63E2E0),
        centerTitle: true,
        title: Text(
          'EMAIL VERIFICATION',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
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
                UserDetailsAdd();
              },
            ),
          ],
        ),
      ),
    );
  }
}
