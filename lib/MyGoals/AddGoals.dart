import 'package:flutter/material.dart';
import 'GoalsType.dart';
import 'dart:convert';
import 'NewGoalsHomePage.dart';
import 'package:http/http.dart' as http;

class AddGoals extends StatefulWidget {
  String currentUserID;
  AddGoals({@required this.currentUserID});
  @override
  _AddGoalsState createState() => _AddGoalsState(currentUserID: currentUserID);
}

class _AddGoalsState extends State<AddGoals> {
  String currentUserID;
  _AddGoalsState({@required this.currentUserID});
  var goalselected = 0;
  TextEditingController name = new TextEditingController();
  TextEditingController value = new TextEditingController();
  TextEditingController year = new TextEditingController();

  Future goalInsert() async {
    String nam = name.text;
    String amoun = value.text;
    String yea = year.text;
    String type = goalselected.toString();
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/Goals/GoalInsert.php';
    print("****************************************************");
    print("$name,$amoun,$year,$type");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Name": nam,
        "Amount": amoun,
        "Type": type,
        "Year": yea,
        "UserID": currentUserID,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NewGoalsPage(
                    currentUserID: currentUserID,
                  )));
    } else {
      print(message1);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        title: Text(
          'ADD GOAL',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Material(
              color: Color(0xffECEFF1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  height: height * 0.65,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 8, top: 15, bottom: 10),
                          child: Text('Goal Type',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: (height < 640) ? height * 0.18 : height * 0.2,
                          width: width,
                          child: ListView.builder(
                            itemCount: category.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        goalselected = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: goalselected == index
                                          ? BoxDecoration(
                                              border: Border.all(
                                                width: 4,
                                                color: Color(0xff63E2E0),
                                              ),
                                            )
                                          : BoxDecoration(
                                              border: Border.all(
                                                width: 4,
                                                color: Color(0xff373D3F),
                                              ),
                                            ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            category[index].imageUrl,
                                            height: (height < 640)
                                                ? height * 0.05
                                                : height * 0.1,
                                            width: width * 0.2,
                                          ),
                                          Text(
                                            category[index].name,
                                            style: TextStyle(
                                                color: Color(0xff373D3F),
                                                fontWeight:
                                                    goalselected == index
                                                        ? FontWeight.bold
                                                        : FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Goal Name',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: height < 640 ? height * 0.06 : height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff373D3F)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff63E2E0),
                                  ),
                                ),
                                hintText: "Enter name",
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Goal Amount',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: height < 640 ? height * 0.06 : height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: value,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff373D3F)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff63E2E0),
                                    ),
                                  ),
                                  hintText: "Enter Amount"),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Achieve Goal By',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: height < 640 ? height * 0.06 : height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: year,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff373D3F)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff63E2E0),
                                    ),
                                  ),
                                  hintText: "Enter year"),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: () {
                              goalInsert();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ADD GOAL',
                                style: TextStyle(color: Color(0xff373D3F)),
                              ),
                            ),
                            color: Color(0xff63E2E0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
