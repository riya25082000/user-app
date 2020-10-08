import 'package:finance_app/Income_Expenses/categoryinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'income2.dart';

class Add extends StatefulWidget {
  String currentUserId;
  Add({@required this.currentUserId});
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  int incsel = 0;
  Future incomeInsert() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/IncomeInsert.php';
    print("****************************************************");
    print("$incsel,${value.text},${widget.currentUserId},");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Type": incsel.toString(),
        "Amount": value.text,
        "UserID": widget.currentUserId,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => income2(
                    currentUserID: widget.currentUserId,
                  )));
    } else {
      print(message1);
    }
  }

  TextEditingController value = TextEditingController();
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
        centerTitle: true,
        title: Text(
          'ADD INCOME',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
        backgroundColor: Color(0xff63E2E0),
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
                          child: Text('Income Type',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: (height < 640) ? height * 0.18 : height * 0.2,
                          width: width,
                          child: ListView.builder(
                            itemCount: inccategory.length,
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
                                        incsel = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: incsel == index
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
                                            inccategory[index].imageUrl,
                                            height: (height < 640)
                                                ? height * 0.05
                                                : height * 0.1,
                                            width: width * 0.2,
                                          ),
                                          Text(
                                            inccategory[index].iname,
                                            style: TextStyle(
                                                color: Color(0xff373D3F),
                                                fontWeight: incsel == index
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
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Income Amount',
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
                          height: 30,
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: () {
                              incomeInsert();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ADD INCOME',
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

class AddE extends StatefulWidget {
  String currentUserId;
  AddE({@required this.currentUserId});
  @override
  _AddEState createState() => _AddEState();
}

class _AddEState extends State<AddE> {
  int expsel = 0;
  Future expenseInsert() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/ExpenseInsert.php';
    print("****************************************************");
    print("$expsel,${val.text},${widget.currentUserId},");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Type": expsel.toString(),
        "Amount": val.text,
        "UserID": widget.currentUserId,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => income2(
                    currentUserID: widget.currentUserId,
                  )));
    } else {
      print(message1);
    }
  }

  TextEditingController val = TextEditingController();
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
        centerTitle: true,
        title: Text(
          'ADD EXPENSE',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
        backgroundColor: Color(0xff63E2E0),
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
                          child: Text('Expense Type',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: (height < 640) ? height * 0.18 : height * 0.2,
                          width: width,
                          child: ListView.builder(
                            itemCount: expcategory.length,
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
                                        expsel = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: expsel == index
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
                                            expcategory[index].imageUrl,
                                            height: (height < 640)
                                                ? height * 0.05
                                                : height * 0.1,
                                            width: width * 0.2,
                                          ),
                                          Text(
                                            expcategory[index].ename,
                                            style: TextStyle(
                                                color: Color(0xff373D3F),
                                                fontWeight: expsel == index
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
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Expense Amount',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: height < 640 ? height * 0.06 : height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: val,
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
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: () {
                              expenseInsert();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ADD EXPENSE',
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
