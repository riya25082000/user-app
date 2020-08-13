import 'package:flutter/material.dart';
import 'YourGoals.dart';
import 'GoalsType.dart';
import 'AddGoals.dart';

class GoalsHomePage extends StatefulWidget {
  @override
  _GoalsHomePageState createState() => _GoalsHomePageState();
}

class _GoalsHomePageState extends State<GoalsHomePage> {
  int selectedIndex = 0;

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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Goals',
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        height: height * 0.65,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.outlined_flag,
                          color: Color(0xff373D3F),
                        ),
                        Text(
                          'My Goals',
                          style: TextStyle(
                              color: Color(0xff373D3F),
                              fontWeight: FontWeight.bold),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AddGoals()));
                          },
                          child: Text(' + Add Goal'),
                          color: Color(0xff63E2E0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: height * 0.1,
                      width: width,
                      color: Color(0xffECEFF1),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: goalsType.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 30,
                              ),
                              child: Text(
                                goalsType[index],
                                style: TextStyle(
                                    color: index == selectedIndex
                                        ? Color(0xff63E2E0)
                                        : Color(0xff373D3F),
                                    fontSize: 20,
                                    fontWeight: index == selectedIndex
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    letterSpacing: 1),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Container(
                            color: Color(0xffECEFF1),
                            child: (selectedIndex == 0)
                                ? yourGoals(context, currentGoals, height,
                                    width, ownCurrentGoals)
                                : yourGoals(context, completedGoals, height,
                                    width, ownCompletedGoals),
                          ),
                        ),
                      ],
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