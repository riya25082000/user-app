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
  String name, amount, year, type;

  Future goalInsert() async {
    type = goalselected.toString();
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/Goals/GoalInsert.php';
    print("****************************************************");
    print("$name,$amount,$year,$type");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Name": name,
        "Amount": amount,
        "Type": type,
        "Year": year,
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

  String validateName(String value) {
    if (value.isEmpty) {
      _loading = false;
      return 'Name is required';
    } else if (value.length < 3) {
      _loading = false;
      return 'Name must be more than 2 charater';
    } else
      return null;
  }

  String validateYear(String value) {
// Indian Mobile number are of 10 digit only
    if (value.isEmpty) {
      _loading = false;
      return 'Year is required';
    } else if (value.length != 4) {
      _loading = false;
      return 'Mobile Number must be of 10 digit';
    } else
      return null;
  }

  String validateAmount(String value) {
// Indian Mobile number are of 10 digit only
    if (value.isEmpty) {
      _loading = false;
      return 'Amount is required';
    } else
      return null;
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      goalInsert();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _loading
        ? new Container(
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                    child: new CircularProgressIndicator(
                  backgroundColor: Color(0xff63E2E0),
                ))),
          )
        : new Container();
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
                    child: Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
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
                            height:
                                (height < 640) ? height * 0.18 : height * 0.2,
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
                            height:
                                height < 640 ? height * 0.06 : height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                validator: validateName,
                                onSaved: (v1) {
                                  name = v1;
                                },
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
                            height:
                                height < 640 ? height * 0.06 : height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: validateAmount,
                                onSaved: (v3) {
                                  amount = v3;
                                },
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
                            height:
                                height < 640 ? height * 0.06 : height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: validateYear,
                                onSaved: (v2) {
                                  year = v2;
                                },
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
                                setState(() {
                                  _loading = true;
                                });
                                _validateInputs();
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
                          ),
                          Align(
                            child: loadingIndicator,
                            alignment: FractionalOffset.center,
                          ),
                        ],
                      ),
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
