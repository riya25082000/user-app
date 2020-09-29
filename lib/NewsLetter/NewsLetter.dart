import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import '../erroralert.dart';
import 'ShowLetter.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class NewsLetter extends StatefulWidget {
  String currentUserID;
  NewsLetter({@required this.currentUserID});
  @override
  _NewsLetterState createState() =>
      _NewsLetterState(currentUserID: currentUserID);
}

class _NewsLetterState extends State<NewsLetter> {
  String currentUserID;
  _NewsLetterState({@required this.currentUserID});
  String x = "May 2020";
  List letter = [];
  bool _loading;
  void getLetter() async {
    try {
      setState(() {
        _loading = true;
      });
      var url =
          'http://sanjayagarwal.in/Finance App/UserApp/NewsLetter/NewsLetterDetails.php';
      final response = await http
          .post(
            url,
            body: jsonEncode(<String, String>{}),
          )
          .timeout(Duration(seconds: 30));
      var message = await jsonDecode(response.body);
      print("****************************************");
      print(message);
      print("****************************************");
      setState(() {
        letter = message;
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
    print("****************************************");
    print("****************************************");
    getLetter();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        backgroundColor: Color(0xff63E2E0),
        centerTitle: true,
        title: Text(
          'NEWSLETTER',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                backgroundColor: Color(0xff63E2E0),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    physics: ScrollPhysics(),
                    children: List.generate(letter.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          print(letter[index]['nurl']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ShowLetter(
                                        int.parse(letter[index]['nid']),
                                        letter[index]['ntitle'],
                                        letter[index]['nurl'],
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xff48F5D9), Colors.white]),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  letter[index]['ntitle'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
