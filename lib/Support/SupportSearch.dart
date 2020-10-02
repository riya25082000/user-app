import 'dart:convert';

import 'package:finance_app/Support/showQuestions.dart';
import 'package:finance_app/userInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class SupportUserPage extends StatefulWidget {
  String currentUserID;
  SupportUserPage({@required this.currentUserID});
  @override
  _SupportUserPage createState() => _SupportUserPage();
}
List ques = [], supcategory = [];
class _SupportUserPage extends State<SupportUserPage> {
  String currentUserID;
  _SupportUserPage({@required this.currentUserID});

  List searchList = [];
  Future userSearchData() async {
    var url = 'http://sanjayagarwal.in/Finance App/UserApp/Support/userCategoryData.php';
    final response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      for (var i = 0; i < jsonData.length; i++) {
        searchList.add(jsonData[i]['sname']);
       // searchList.add(jsonData[i]['sid']);
      }

     // print(searchList);
    }
    var message2 = await jsonDecode(response.body);
    print("****************************************");
    print(message2 );
    print("****************************************");
    setState(() {

      supcategory = message2;
      //print(supcategory[0]["sid"]);

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userSearchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(
          onPressed: () {

            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SupportUserPage()));
            });
            // Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        backgroundColor: Color(0xff63E2E0),
        centerTitle: true,

        title: Text(
          'SEARCH CATEGORY',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),

        actions: <Widget>[
          //categorybuilder(),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: UserSearch(list: searchList));
            },
            icon: Icon(
              Icons.search,
              color: Color(0xff373D3F),
            ),
          ),
          //categorybuilder(),

        ],

      ),

    );
  }
  Widget categorybuilder() {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: supcategory.length,
      itemBuilder: (BuildContext cntx, int index) {
        return GestureDetector(
          onTap: () {
            //print(supcategory[index]["sname"]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => showQuestion(
                      supcategory[index]["sname"],
                      int.parse(supcategory[index]["sid"]),
                      currentUserID: currentUserID,
                    )));
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.purple,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(supcategory[index]["sname"]),
                    Icon(
                      Icons.print,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserSearch extends SearchDelegate<String> {
  List<dynamic> list, list2;
  var list3;
  UserSearch({this.list});

  Future userData() async {
    var url = 'http://sanjayagarwal.in/Finance App/UserApp/Support/SupportCategoryData.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Name": query,
      }),
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      list3=jsonData[0]["sid"];

     list2 = jsonData;
      print(
          "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print("answer");
      print(list3);
      print(
          "**********************************************************************");
      return jsonData;
    }


  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: userData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                print(index);

                var list = snapshot.data[index];


                //print(list);

                SchedulerBinding.instance.addPostFrameCallback((_) {


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => showQuestion(
                            list["sname"],
                            int.parse(list3),
                            currentUserID: "987654321",
                          )));

                });

                return ListTile(
                  title: Text(list['sname']),
                );
              });
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData = query.isEmpty
        ? list
        : list.where((element) => element.contains(query)).toList();
    return listData.isEmpty
        ? Center(
        child: Text(
          'NO CATEGORY FOUND',
          style: TextStyle(fontSize: 20),
        ))
        : ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              query = listData[index];
              showResults(context);
            },
            title: Text(listData[index]),
          );
        });
  }
}
