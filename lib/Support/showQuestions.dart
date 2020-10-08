import 'dart:async';

import 'package:finance_app/Support/SupportSearch.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../erroralert.dart';
import 'Support.dart';

class showQuestion extends StatefulWidget {
  String currentUserID;
  String cate;
  int suid;
  showQuestion(this.cate, this.suid, {@required this.currentUserID});
  @override
  _showQuestionState createState() =>
      _showQuestionState(currentUserID: currentUserID);
}

class _showQuestionState extends State<showQuestion> {
  List ques = [];
  bool _loading;
  void getQues() async {
    try {
      print(widget.suid.toString());
      setState(() {
        _loading = true;
      });
      var url =
          'http://sanjayagarwal.in/Finance App/UserApp/Support/SupportQuestion.php';
      final response = await http
          .post(
            url,
            body: jsonEncode(<String, String>{
             'sid': widget.suid.toString(),

            }),
          )
          .timeout(Duration(seconds: 30));
      var message = await jsonDecode(response.body);
      print("****************************************");
      print(message);
      print("****************************************");
      setState(() {
        ques = message;
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
    getQues();
    // TODO: implement initState
    super.initState();
  }

  Widget QandA() {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: ques.length,
      itemBuilder: (BuildContext cntx, int index) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xff63E2E0),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(ques[index]["question"]),
                  Text(ques[index]["answer"])
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String currentUserID;
  _showQuestionState({@required this.currentUserID});
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
                    height: height * 0.15,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => Support()));
                              },
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.cate,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QandA(),
                ],
              ),
            ),
    );
  }
}
