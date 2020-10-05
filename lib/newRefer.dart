import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:async';
import 'dart:io';
import 'components/ButtonsWidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'erroralert.dart';

class RewardandRefer extends StatefulWidget {
  String currentUserID;
  RewardandRefer({@required this.currentUserID});
  @override
  _RewardandReferState createState() =>
      _RewardandReferState(currentUserID: currentUserID);
}

class _RewardandReferState extends State<RewardandRefer> {
  String currentUserID;
  _RewardandReferState({@required this.currentUserID});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String rCode = '';
  List<List> rewards = [
    [
      'rewards1',
      'rewards detailpoiuytrewqasdfghj kll,mnbvcxzasdfghjkl;poiuytrewqasdfghjkll,mnbvcxzsdfghjklpoiuytrewqasdfghjkl,mnbvcxzasdfghjklpoiuy'
    ],
    ['rewards1', 'rewards detail'],
    ['rewards1', 'rewards detail'],
    ['rewards1', 'rewards detail'],
  ];
  void getReferData() async {
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
    print(message[0]['ReferalCode']);
    print("****************************************");
    setState(() {
      rCode = message[0]['ReferalCode'];
      ReferredTotal();
    });
    var url1 = 'http://sanjayagarwal.in/Finance App/ReferedToDetails.php';
    final response1 = await http.post(
      url1,
      body: jsonEncode(<String, String>{
        "CodeUsed": message[0]['ReferalCode'],
      }),
    );
    var message1 = await jsonDecode(response1.body);
    print("****************************************");
    print(message1);
    print("****************************************");
  }

  bool _loading;
  List rew = [];
  void getRewardHistory() async {
    setState(() {
      _loading = true;
    });
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/Rewards/RewardHistory.php';
    try {
      final response = await http
          .post(
            url,
            body: jsonEncode(<String, String>{
              "UserID": currentUserID,
            }),
          )
          .timeout(const Duration(seconds: 30));
      var message = await jsonDecode(response.body);
      print("****************************************");
      print(message);
      print("****************************************");
      setState(() {
        rew = message;
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

  int total = 0;
  void SumBonus() async {
    var url3 =
        'http://sanjayagarwal.in/Finance App/UserApp/Rewards/RewardTotal.php';
    final response3 = await http.post(
      url3,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message3 = jsonDecode(response3.body);
    setState(() {
      total = int.parse(message3[0]["sum(rpoints)"]);
    });
  }

  double counter = 0.0;
  void ReferredTotal() async {
    var url3 =
        'http://sanjayagarwal.in/Finance App/UserApp/Rewards/RewardGraph1.php';
    final response3 = await http.post(
      url3,
      body: jsonEncode(<String, String>{
        "PromoCode": rCode,
      }),
    );
    var message3 = jsonDecode(response3.body);
    setState(() {
      counter = double.parse(message3[0]["count(UserID)"]);
      print("**********");
      print(counter);
      counter = counter / 12;
    });
  }

  TextEditingController coder = TextEditingController();
  int pointer = 0;
  void RewardRedeem() async {
    try {
      DateTime d = DateTime.now();
      var url3 =
          'http://sanjayagarwal.in/Finance App/UserApp/Rewards/RewardRedeem.php';
      final response3 = await http.post(
        url3,
        body: jsonEncode(<String, String>{
          "RewardCode": coder.text,
        }),
      );
      var message3 = jsonDecode(response3.body);
      setState(() {
        pointer = int.parse(message3[0]["RewardPoints"]);
      });
      var url =
          'http://sanjayagarwal.in/Finance App/UserApp/Rewards/GetReward.php';
      print("****************************************************");
      print("$currentUserID ** ${coder.text} ** $pointer ** ${d.toString()} ");
      print("****************************************************");
      final response1 = await http.post(
        url,
        body: jsonEncode(<String, String>{
          "UserID": currentUserID,
          "rcode": coder.text,
          "rpoints": pointer.toString(),
          "Date": d.toString(),
        }),
      );
      var message1 = jsonDecode(response1.body);
      if (message1 == "Successful Insertion") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RewardandRefer(
                      currentUserID: currentUserID,
                    )));
      } else {
        print(message1);
      }
    } on TimeoutException catch (e) {
      alerttimeout(context, currentUserID);
    } on Error catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Reward Code"),
            content:
                Text("The code you have entered is invalid or doesn't exist."),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RewardandRefer(
                                currentUserID: currentUserID,
                              )));
                },
                child: Text("Ok"),
              )
            ],
          );
        },
      );
    } on SocketException catch (e) {
      alertinternet(context, currentUserID);
    }
  }

  @override
  void initState() {
    getReferData();
    getRewardHistory();
    SumBonus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
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
          'REWARDS & REFERRALS',
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
          : LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Reward 1"),
                        ),
                        LinearPercentIndicator(
                          lineHeight: 14.0,
                          percent: counter,
                          backgroundColor: Colors.grey,
                          progressColor: Color(0xff63E2E0),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Reward 2"),
                        ),
                        LinearPercentIndicator(
                          lineHeight: 14.0,
                          percent: 0.3,
                          backgroundColor: Colors.grey,
                          progressColor: Color(0xff63E2E0),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('Total Reward Points: '),
                            Text(total.toString()),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 24),
                          child: Container(
                            height: height * 0.07,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                      color: Colors.black12),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    '$rCode',
                                    style: TextStyle(
                                        fontSize: height * 0.03,
                                        color: Color(0xFF373D3F)),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Text('Copy Code',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: height * 0.02,
                                                color: Color(0xff373D3F))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              color: Color(0xff63E2E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Share your Referral Code"),
                              ),
                              onPressed: () {
                                final RenderBox box =
                                    context.findRenderObject();
                                Share.share(
                                    "Hey! I am sharing my referral code with you: $rCode",
                                    subject: "Code",
                                    sharePositionOrigin:
                                        box.localToGlobal(Offset.zero) &
                                            box.size);
                              },
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Center(child: Text('HOW TO EARN')),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 15),
                          child: Container(
                            height: height * 0.15,
                            child: ListView(
                              children: List.generate(2, (int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Flexible(
                                        child: Text(
                                          rewards[index][0],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: height * 0.022,
                                            color: Color(0xff373D3F),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text('View More Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.02,
                                    color: Color(0xff373D3F),
                                  )),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: coder,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: 'Have a code?',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: TextStyle(
                                      color: Color(0xff373D3F),
                                      fontSize: height * 0.02),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              RaisedButton(
                                color: Color(0xff63E2E0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'REDEEM',
                                  style: TextStyle(
                                      color: Color(0xff373D3F),
                                      fontSize: height * 0.02),
                                ),
                                onPressed: () {
                                  RewardRedeem();
                                },
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: Color(0xff63E2E0),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              padding: EdgeInsets.all(16),
                              child: Center(
                                  child: Text(
                                'Swipe up to see your Reward History',
                                style: TextStyle(
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff373D3F)),
                              ))),
                          onVerticalDragStart: (DragStartDetails details) {
                            _scaffoldKey.currentState
                                .showBottomSheet<Null>((BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Color(0xff63E2E0),
                                ),
                                height:
                                    height < 640 ? height * 0.7 : height * 0.5,
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Your Reward History',
                                        style: TextStyle(
                                            color: Color(0xff373D3F),
                                            fontSize: height * 0.02,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: height * 0.4,
                                        child: ListView.builder(
                                          itemCount: rew.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    color: Colors.white,
                                                  ),
                                                  height: 80,
                                                  width: width * 0.8,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 3,
                                                          child: Center(
                                                            child: Text(
                                                              rew[index]
                                                                  ["rcode"],
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff373D3F),
                                                                fontSize:
                                                                    height *
                                                                        0.03,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                'Points Earned',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff373D3F),
                                                                    fontSize:
                                                                        height *
                                                                            0.02,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Text(
                                                                rew[index]
                                                                    ["rpoints"],
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff373D3F),
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
    );
  }
}
