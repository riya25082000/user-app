import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../erroralert.dart';
import '../userInfo.dart';
import 'showQuestions.dart';
import 'dart:async';
import 'dart:io';

class Support extends StatefulWidget {
  String currentUserID;
  Support({@required this.currentUserID});
  @override
  _SupportState createState() => _SupportState(currentUserID: currentUserID);
}

class _SupportState extends State<Support> {
  String currentUserID;
  _SupportState({@required this.currentUserID});

  List ques = [], supcategory = [];
  bool _loading;

  void getCategory() async {
    try {
      setState(() {
        _loading = true;
      });
      var url2 =
          'http://sanjayagarwal.in/Finance App/UserApp/Support/SupportCategory.php';
      final response2 = await http
          .post(
            url2,
            body: jsonEncode(<String, String>{
              "UserID": currentUserID,
            }),
          )
          .timeout(Duration(seconds: 30));
      var message2 = await jsonDecode(response2.body);
      print("****************************************");
      print(message2 );
      print("****************************************");
      setState(() {
        supcategory = message2;
        _loading = false;
      });
    } on TimeoutException catch (e) {
      alerttimeout(context, currentUserID);
    } on Error catch (e) {
      alerterror(context, currentUserID);
    } on SocketException catch (e) {
      alertinternet(context, currentUserID);
    }
  }

  @override
  void initState() {
    // print("****************************************");
    // print(currentUserID);
    // print("****************************************");
    getCategory();
    // TODO: implement initState
    super.initState();
  }

  Widget categorybuilder() {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: supcategory.length,
      itemBuilder: (BuildContext cntx, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => showQuestion(
                          supcategory[index]["sname"],
                          int.parse(supcategory[index]["sid"]),
                          currentUserID: currentUserID,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.purple,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(supcategory[index]["sname"]),
                    Icon(
                      Icons.print,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextEditingController searchques = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                backgroundColor: Color(0xff63E2E0),
              ),
            )
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/app.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "How can we help you?",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: width * 0.6,
                                decoration: BoxDecoration(color: Colors.white),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Enter your search here",
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: searchques,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.search),
                                color: Colors.white,
                                onPressed: () {},
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  categorybuilder(),
                ],
              ),
            ),
    );
  }


}

