import 'dart:async';

import 'package:finance_app/SignUP_PageWith_Chnages/SignIn_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../NotificationPage.dart';
import '../menu_page.dart';

class HomePage extends StatefulWidget {
  final String currentUserID;
  HomePage({@required this.currentUserID});
  @override
  _HomePageState createState() => _HomePageState(currentUserID: currentUserID);
}

class _HomePageState extends State<HomePage> {
  final String currentUserID;
  Timer _timer;

  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseTimer();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }


  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  void _handleUserInteraction([_]) {
    if (!_timer.isActive) {
      // This means the user has been logged out
      return;
    }

    _timer.cancel();
    _initialiseTimer();
  }


  void _initialiseTimer() {
    _timer = Timer.periodic(const Duration(minutes:1), (_) => logoutUser);
  }

  void logoutUser(){

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginPage()));
    _timer.cancel();
  }
  _HomePageState({@required this.currentUserID});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff373D3F),
        ),
        backgroundColor: Color(0xff63E2E0),
        centerTitle: true,
        title: Text(
          'HOME',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
      ),
      drawer: Drawer(
        child: menuPage(currentUserID: currentUserID,),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Hi User',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff373D3F),
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleUserInteraction,
                          onPanDown: _handleUserInteraction,
                          onScaleStart: _handleUserInteraction,
                        ),
                        IconButton(
                          iconSize: 40,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        NotificationPage(currentUserID: currentUserID,)));
                          },
                          icon: Icon(Icons.notifications_none),
                          color: Color(0xff373D3F),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 0, //extend the shadow
                              )
                            ]),
                        height: height * 0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text('Invested'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('43,74,652.34'),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Current'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('51,80,487.55'),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('P&L'),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '+8,05,835.20',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '+18.42%',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
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
