import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  String currentUserID;
  UserProfile({@required this.currentUserID});
  @override
  _UserProfileState createState() =>
      _UserProfileState(currentUserID: currentUserID);
}

class _UserProfileState extends State<UserProfile> {
  String currentUserID;
  _UserProfileState({@required this.currentUserID});
  String dropdownValue;
  String userCode;
  bool isEditing = false;
  SharedPreferences preferences;
  String id = "";

  void getUserData() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/Profile/UserDetails.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      name = message[0]['Name'];
      dob = message[0]['DOB'];
      mobile = message[0]['Mobile'];
      pan = message[0]['PAN'];
      referalCode = message[0]['ReferalCode'];
      dropdownValue = message[0]['Gender'];
      userCode = message[0]['UserID'];
      email = message[0]['Email'];
    });
  }

  void profileUpdate() async {
    var url = 'http://sanjayagarwal.in/Finance App/UserUpdate.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Name": name,
        "DOB": dob,
        "Mobile": mobile,
        "PAN": pan,
        "Email": email,
        "UserID": userCode,
        "Gender": dropdownValue,
        "ReferalCode": referalCode
      }),
    );
    print(referalCode);
    var message1 = await jsonDecode(response1.body);
    if (message1["message"] == "Successful Updation") {
      print("Successfully Updated");
    } else {
      print(message1["message"]);
    }
  }

  void switchState() {
    if (isEditing) {
      isEditing = false;
    } else {
      isEditing = true;
    }
  }

  String name = "",
      dob = "",
      mobile = "",
      pan = "",
      referalCode = "",
      email = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    double tileHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Color(0xff63E2E0),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isEditing) {
            profileUpdate();
            getUserData();
          }
          setState(() {
            switchState();
          });
          // Add your onPressed code here!
        },
        child: isEditing ? Icon(Icons.save) : Icon(Icons.edit),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Name(as on PAN Card)',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  isEditing
                      ? TextFormField(
                          initialValue: name,
                          onChanged: (value) {
                            name = value;
                          },
                        )
                      : Text(
                          '$name',
                          style: TextStyle(
                            fontSize: tileHeight / 55,
                            color: Colors.black45,
                          ),
                        ),
                  isEditing
                      ? SizedBox()
                      : Divider(
                          color: Colors.black45,
                        ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                  Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  isEditing
                      ? TextFormField(
                          initialValue: dob,
                          onChanged: (value) {
                            dob = value;
                          },
                        )
                      : Text(
                          '$dob',
                          style: TextStyle(
                            fontSize: tileHeight / 55,
                            color: Colors.black45,
                          ),
                        ),
                  isEditing
                      ? SizedBox()
                      : Divider(
                          color: Colors.black45,
                        ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                  Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  isEditing
                      ? TextFormField(
                          initialValue: mobile,
                          onChanged: (value) {
                            mobile = value;
                          },
                        )
                      : Text(
                          '$mobile',
                          style: TextStyle(
                            fontSize: tileHeight / 55,
                            color: Colors.black45,
                          ),
                        ),
                  isEditing
                      ? SizedBox()
                      : Divider(
                          color: Colors.black45,
                        ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  isEditing
                      ? TextFormField(
                          initialValue: email,
                          onChanged: (value) {
                            email = value;
                          },
                        )
                      : Text(
                          '$email',
                          style: TextStyle(
                            fontSize: tileHeight / 55,
                            color: Colors.black45,
                          ),
                        ),
                  isEditing
                      ? SizedBox()
                      : Divider(
                          color: Colors.black45,
                        ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                  Text(
                    'PAN Number',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  isEditing
                      ? TextFormField(
                          initialValue: pan,
                          onChanged: (value) {
                            pan = value;
                          },
                        )
                      : Text(
                          '$pan',
                          style: TextStyle(
                            fontSize: tileHeight / 55,
                            color: Colors.black45,
                          ),
                        ),
                  isEditing
                      ? SizedBox()
                      : Divider(
                          color: Colors.black45,
                        ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                  Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  isEditing
                      ? DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: tileHeight / 40,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.black45, fontSize: tileHeight / 55),
                          underline: Container(
                            height: 2,
                            color: Colors.black45,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['Male', 'Female', '']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      : Text(
                          '$dropdownValue',
                          style: TextStyle(
                            fontSize: tileHeight / 55,
                            color: Colors.black45,
                          ),
                        ),
                  isEditing
                      ? SizedBox()
                      : Divider(
                          color: Colors.black45,
                        ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                  Text(
                    'Referal Code',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),

                  ),

                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  Text(

                    '$referalCode',
                    style: TextStyle(
                      fontSize: tileHeight / 55,
                      color: Colors.black45,
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                  ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                  Text(
                    'Unique Client Code',
                    style: TextStyle(
                      fontSize: tileHeight / 40,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: tileHeight / 80,
                  ),
                  Text(
                    '$userCode',
                    style: TextStyle(
                      fontSize: tileHeight / 55,
                      color: Colors.black45,
                    ),
                  ),
                  isEditing
                      ? SizedBox()
                      : Divider(
                          color: Colors.black45,
                        ),
                  SizedBox(
                    height: tileHeight / 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
