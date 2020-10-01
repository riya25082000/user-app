import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'RewardHistory.dart';
import 'components/ButtonsWidget.dart';

class RewardsPages extends StatefulWidget {
  String currentUserID;
  RewardsPages({@required this.currentUserID});

  @override
  _RewardsPagesState createState() =>
      _RewardsPagesState(currentUserID: currentUserID);
}

class _RewardsPagesState extends State<RewardsPages> {
  String currentUserID;
  _RewardsPagesState({@required this.currentUserID});
  String rCode = 'ASd3f2';
  List<List> redeems = [
    ["p45ik9", 15],
    ["p45ik9", 15],
    ["p45ik9", 15],
    ["p45ik9", 15],
    ["p45ik9", 15],
    ["p45ik9", 15],
    ["p45ik9", 15],
  ];
  List<List> rewards = [
    [
      'rewards1',
      'rewards detailpoiuytrewqasdfghj kll,mnbvcxzasdfghjkl;poiuytrewqasdfghjkll,mnbvcxzsdfghjklpoiuytrewqasdfghjkl,mnbvcxzasdfghjklpoiuy'
    ],
    ['rewards1', 'rewards detail'],
    ['rewards1', 'rewards detail'],
    ['rewards1', 'rewards detail']
  ];
  Map<String, double> dataMap = new Map();
  Map<String, double> dataMap2 = new Map();

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Redemtions", () => codesUsed.length.toDouble());
    dataMap.putIfAbsent(
        "Redemtionsleft", () => 30 - codesUsed.length.toDouble());
    dataMap2.putIfAbsent("Investments", () => codesUsed.length.toDouble());
    dataMap2.putIfAbsent(
        "Investmentleft", () => 30 - codesUsed.length.toDouble());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: height * 0.18,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PieChart(
                            dataMap: dataMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32.0,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            showChartValuesInPercentage: false,
                            showChartValues: false,
                            showChartValuesOutside: false,
                            chartValueBackgroundColor: Colors.grey[200],
                            colorList: [
                              Color(0xff63e2e0),
                              Colors.black12,
                            ],
                            showLegends: false,
                            legendPosition: LegendPosition.right,
                            decimalPlaces: 0,
                            showChartValueLabel: false,
                            initialAngle: 0,
                            chartValueStyle: defaultChartValueStyle.copyWith(
                              color: Colors.blueGrey[900].withOpacity(0.9),
                            ),
                            chartType: ChartType.ring,
                          ),
                          PieChart(
                            dataMap: dataMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32.0,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            showChartValuesInPercentage: false,
                            showChartValues: false,
                            showChartValuesOutside: false,
                            chartValueBackgroundColor: Colors.grey[200],
                            colorList: [
                              Color(0xff63e2e0),
                              Colors.black12,
                            ],
                            showLegends: false,
                            legendPosition: LegendPosition.right,
                            decimalPlaces: 0,
                            showChartValueLabel: false,
                            initialAngle: 0,
                            chartValueStyle: defaultChartValueStyle.copyWith(
                              color: Colors.blueGrey[900].withOpacity(0.9),
                            ),
                            chartType: ChartType.ring,
                          ),
                        ],
                      ),
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
                        Column(
                          children: <Widget>[
                            socialmedia('assets/images/facebook.png'),
                            space(),
                            socialtext('Facebook'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            socialmedia('assets/images/instagram.jpg'),
                            space(),
                            socialtext('Instagram'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            socialmedia('assets/images/wh.png'),
                            space(),
                            socialtext('Whatsapp'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            socialmedia('assets/images/share.png'),
                            space(),
                            socialtext('Share with'),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: Container(
                        height: height * 0.2,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8.0,
                                  spreadRadius: 2.0,
                                  color: Colors.black12),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                'HOW TO EARN',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: height * 0.025,
                                  color: Color(0xff373D3F),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 15),
                                child: Container(
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 15),
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
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.08,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
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
                              onPressed: () {},
                            ),
                          ],
                        ),
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
                            height: height < 640 ? height * 0.7 : height * 0.5,
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
                                      itemCount: codesUsed.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: Colors.white,
                                              ),
                                              height: 80,
                                              width: width * 0.8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child: Text(
                                                          codesUsed[index]
                                                              .codeName,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff373D3F),
                                                            fontSize:
                                                                height * 0.03,
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
                                                            codesUsed[index]
                                                                .points,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff373D3F),
                                                              fontSize:
                                                                  height * 0.02,
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
        },
      ),
    );
  }
}
