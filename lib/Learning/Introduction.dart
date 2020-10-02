import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Introduction extends StatefulWidget {
  String currentUserID;
  String moduleno;
  String modulename; //if you have multiple values add here
  Introduction(this.moduleno, this.modulename,
      {Key key, @required this.currentUserID})
      : super(key: key);
  @override
  _IntroductionState createState() =>
      _IntroductionState(currentUserID: currentUserID);
}

class _IntroductionState extends State<Introduction> {
  String currentUserID;
  _IntroductionState({@required this.currentUserID});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
        title: Column(
          children: <Widget>[
            Text(
              'Module ${widget.moduleno}',
              style: TextStyle(color: Color(0xff373D3F)),
            ),
            Text(
              '${widget.modulename}',
              style: TextStyle(
                  color: Color(0xff373D3F), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xff63E2E0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "What will you learn?",
                            style: TextStyle(
                                color: Color(0xff373D3F),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            "This module will help you to understand the basics of marketing including IPO markets, commonly used jargons, trading terminal, and market events.",
                            style: TextStyle(
                                color: Color(0xff373D3F), fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
