import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/Income_Expenses/addincome.dart';
import 'package:finance_app/Income_Expenses/modifyIE.dart';
import 'package:finance_app/Income_Expenses/widgetcode.dart';
import 'package:finance_app/erroralert.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'categoryinfo.dart';

class income2 extends StatefulWidget {
  String currentUserID;
  income2({@required this.currentUserID});
  @override
  _income2State createState() => _income2State(currentUserID: currentUserID);
}

class _income2State extends State<income2> {
  String currentUserID;
  List i = [], e = [];
  _income2State({@required this.currentUserID});
  bool _loading;
  void deleteIncome(var incomeID) async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/IncomeDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(
          <String, String>{"UserID": currentUserID, "IncomeID": incomeID}),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    if (message == "Successfully Deleted") {
      getIncome();
    } else {
      print(message["message"]);
    }
  }

  void deleteExpense(var expenseID) async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/ExpenseDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(
          <String, String>{"UserID": currentUserID, "ExpenseID": expenseID}),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    if (message == "Successfully Deleted") {
      getExpense();
    } else {
      print(message["message"]);
    }
  }

  void getIncome() async {
    try {
      setState(() {
        _loading = true;
      });
      var url2 =
          'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/IncomeSum.php';
      final response2 = await http
          .post(
            url2,
            body: jsonEncode(<String, String>{
              "UserID": widget.currentUserID,
            }),
          )
          .timeout(Duration(seconds: 30));
      var message2 = jsonDecode(response2.body);
      totalincome = int.parse(message2[0]["sum(Amount)"]);
      var url3 =
          'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/ExpenseSum.php';
      final response3 = await http
          .post(
            url3,
            body: jsonEncode(<String, String>{
              "UserID": widget.currentUserID,
            }),
          )
          .timeout(Duration(seconds: 30));
      var message3 = jsonDecode(response3.body);
      totalexpense = int.parse(message3[0]["sum(Amount)"]);
      savings = totalincome - totalexpense;
      calculatePotential(dropdown, rate, time);
      var url =
          'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/IncomeDetails.php';
      final response = await http
          .post(
            url,
            body: jsonEncode(<String, String>{
              "UserID": currentUserID,
            }),
          )
          .timeout(Duration(seconds: 30));
      var message1 = await jsonDecode(response.body);
      print("****************************************");
      print(message1);
      print("****************************************");
      setState(() {
        i = message1;
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

  void getExpense() async {
    try {
      setState(() {
        _loading = true;
      });
      var url2 =
          'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/IncomeSum.php';
      final response2 = await http
          .post(
            url2,
            body: jsonEncode(<String, String>{
              "UserID": widget.currentUserID,
            }),
          )
          .timeout(Duration(seconds: 30));
      var message2 = jsonDecode(response2.body);
      totalincome = int.parse(message2[0]["sum(Amount)"]);
      var url3 =
          'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/ExpenseSum.php';
      final response3 = await http
          .post(
            url3,
            body: jsonEncode(<String, String>{
              "UserID": widget.currentUserID,
            }),
          )
          .timeout(Duration(seconds: 30));
      var message3 = jsonDecode(response3.body);
      totalexpense = int.parse(message3[0]["sum(Amount)"]);
      savings = totalincome - totalexpense;
      calculatePotential(dropdown, rate, time);
      var url =
          'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/ExpenseDetails.php';
      final response = await http
          .post(
            url,
            body: jsonEncode(<String, String>{
              "UserID": currentUserID,
            }),
          )
          .timeout(Duration(seconds: 30));
      var message4 = await jsonDecode(response.body);
      print("****************************************");
      print(message4);
      print("****************************************");
      setState(() {
        e = message4;
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
    print(currentUserID);
    print("****************************************");
    getIncome();
    getExpense();
    // TODO: implement initState
    super.initState();
  }

  Widget yourValI(
      BuildContext context, double height, double width, List typer) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: choice == 0 ? i.length : e.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      choice == 0
                          ? inccategory[int.parse(typer[index]['Type'])].iname
                          : expcategory[int.parse(typer[index]['Type'])].ename,
                    ),
                    Row(
                      children: <Widget>[
                        Text(typer[index]['Amount']),
                        PopupMenuButton(
                          icon: Icon(Icons.more_horiz),
                          onSelected: (value) {
                            if (value == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          choice == 0
                                              ? modifyI(
                                                  int.parse(
                                                      typer[index]['IncomeID']),
                                                  int.parse(
                                                      typer[index]['Type']),
                                                  typer[index]['Amount'],
                                                  currentUserID: currentUserID,
                                                )
                                              : modifyE(
                                                  int.parse(typer[index]
                                                      ['ExpenseID']),
                                                  int.parse(
                                                      typer[index]['Type']),
                                                  typer[index]['Amount'],
                                                  currentUserID: currentUserID,
                                                )));
                            }
                            if (value == 2) {
                              choice == 0
                                  ? deleteIncome(
                                      typer[index]['IncomeID'],
                                    )
                                  : deleteExpense(
                                      typer[index]['ExpenseID'],
                                    );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text("Edit"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Delete"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              )
            ],
          );
        });
  }

  int choice = 0;
  String dropdown = "Yearly";
  int totalincome = 0,
      totalexpense = 0,
      savings = 0,
      c1 = 0,
      c2 = 0,
      potentialValue = 0,
      rate = 15,
      time = 10;
  void changes(int index) {
    setState(() {
      choice = index;
    });
  }

  List<String> itype = [];
  List<String> etype = [];
  List<String> iamt = [];
  List<String> eamt = [];

  double potential = 0;
  String incometype,
      expensetype,
      typei,
      typee,
      updateincometype,
      updateexpensetype;
  String selected = "income";
  TextEditingController income = new TextEditingController();
  TextEditingController expense = new TextEditingController();
  TextEditingController x = new TextEditingController();
  TextEditingController y = new TextEditingController();
  TextEditingController newiamt = TextEditingController();
  TextEditingController neweamt = TextEditingController();

  void calculatePotential(String value, int r, int t) {
    setState(() {
      if (y.text.isEmpty) {
        t = 10;
      }
      if (x.text.isEmpty) {
        r = 15;
      }
      if (dropdown == "Yearly") {
        potential = savings * pow((1 + (r / (12 * 100))), (t * 12));
      } else {
        potential = savings * pow((1 + (r / 100)), (t));
      }
      potentialValue = potential.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final List<Widget> moneytype = [
      yourValI(context, height, width, i),
      yourValI(context, height, width, e),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        centerTitle: true,
        title: Text(
          'INCOME AND EXPENSE',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
        backgroundColor: Color(0xff63E2E0),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff63E2E0),
        currentIndex: choice,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: changes,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text("Income"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            title: Text("Expense"),
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                backgroundColor: Color(0xff63E2E0),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: dropdown,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xff373D3F),
                            ),
                            iconSize: 16,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdown = newValue;
                                calculatePotential(dropdown, rate, time);
                              });
                            },
                            items: <String>['Yearly', 'Monthly']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        choice == 0
                                            ? Add(
                                                currentUserId: currentUserID,
                                              )
                                            : AddE(
                                                currentUserId: currentUserID,
                                              )));
                          },
                          child: Text(' + Add '),
                          color: Color(0xff63E2E0),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              choice == 0 ? "Income" : "Expense",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: choice == 0
                                      ? Color(0xff63E2E0)
                                      : choice == 1
                                          ? Colors.red
                                          : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  moneytype[choice],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Total Income",
                          style:
                              TextStyle(color: Color(0xff373D3F), fontSize: 16),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: (totalincome == null)
                              ? textpart(context, "00")
                              : textpart(context, totalincome.toString())),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Total Expense",
                          style:
                              TextStyle(color: Color(0xff373D3F), fontSize: 16),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: (totalexpense == null)
                              ? textpart(context, "00")
                              : textpart(context, totalexpense.toString())),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "$dropdown Savings",
                            style: TextStyle(
                                color: Color(0xff373D3F), fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: (savings == null)
                              ? textpart(context, "00")
                              : textpart(context, savings.toString()),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: height < 640 ? height * 0.2 : height * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff373D3F),
                          ),
                          color: Color(0xff63E2E0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "Potential Value of your Savings ",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 14)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Time(Years)",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 14),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 30,
                                      child: TextField(
                                        onChanged: (t) {
                                          setState(() {
                                            time = int.parse(t);
                                            calculatePotential(
                                                dropdown, rate, time);
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        controller: y,
                                        decoration: InputDecoration(
                                          hintText: "10",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Rate(%)",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 14),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 30,
                                      child: TextField(
                                        onChanged: (r) {
                                          setState(() {
                                            rate = int.parse(r);
                                            calculatePotential(
                                                dropdown, rate, time);
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        controller: x,
                                        decoration: InputDecoration(
                                          hintText: "15",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Center(
                              child: Text("Rs. $potentialValue",
                                  style: TextStyle(
                                      color: Color(0xff373D3F), fontSize: 24)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
