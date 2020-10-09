import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Security/SecurityMenu.dart';

class DisableTouchID extends StatefulWidget {
  String currentUserID;
  DisableTouchID({@required this.currentUserID});
  @override
  _DisableTouchIDState createState() =>
      _DisableTouchIDState(currentUserID: currentUserID);
}

class _DisableTouchIDState extends State<DisableTouchID> {
  String currentUserID;
  _DisableTouchIDState({@required this.currentUserID});
  int able;
  String dropdownValue ;

  @override
  void initState() {
    super.initState();
    TouchIDGet();
  }
  Future TouchIDGet() async {
    var url =
        'http://sanjayagarwal.in/Finance App/touchIDGet.php';

    print(currentUserID);

    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "1") {
      //dropdownValue='Disable';
      setState(() {
        dropdownValue='Disable';
      });
    }
    else if(message1 == "0") {
      setState(() {
        dropdownValue='Enable';
      });
    }
    print("dem");
    print(message1);
  }

  Future TouchIDUpdate() async {
    var url = 'http://sanjayagarwal.in/Finance App/touchIDDisable.php';
    if (dropdownValue == 'Enable') {
      able = 0;
    } else {
      able = 1;
    }
    print(currentUserID);
    print(able);
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
        "dropdownvalue": able.toString(),
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Updation") {
      TouchIDGet();
      print(message1);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SecurityMenu(
                    currentUserID: currentUserID,
                  )));
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     // return AlertDialog(
      //     //   title: Text("Password Update Successful"),
      //     //   content: Text("Your password has been changed successfully."),
      //     //   // actions: [
      //     //   //   FlatButton(
      //     //   //     onPressed: () {
      //     //   //       Navigator.push(
      //     //   //           context,
      //     //   //           MaterialPageRoute(
      //     //   //               builder: (BuildContext context) => SecurityMenu()));
      //     //   //     },
      //     //   //     child: Text("Ok"),
      //     //   //   )
      //     //   // ],
      //     // );
      //   },
      // );
    } else {
      print(message1);
    }
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  'TouchID',
                  style: TextStyle(
                    fontSize: tileHeight / 40,
                    color: Colors.black87,
                  ),
                ),
                DropdownButton<String>(
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
                      print(dropdownValue);
                    });
                  },
                  items: <String>[
                    'Enable',
                    'Disable',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    TouchIDUpdate();
                  },
                  child: Text(
                    "Change ",
                    style: TextStyle(
                        color: Color(0xff373D3F),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  elevation: 6.0,
                  color: Color(0xff63E2E0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
