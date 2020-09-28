import 'package:finance_app/newadvisor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_text_field/responsive_text_field.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Advisor extends StatefulWidget {
  final String currentUserID;
  Advisor({@required this.currentUserID});

  @override
  _AdvisorState createState() => _AdvisorState();
}

class _AdvisorState extends State<Advisor> {
  String adName='';
  String adCode='';
  String adEmail = '';
  String adPhone = '';
  void getAdvisor() async {
    print("****************************************");
    print('ch1');
    print("****************************************");
    var url = 'http://sanjayagarwal.in/Finance App/AdvisorOfUser.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": widget.currentUserID,
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
  }
  @override
  void initState() {
    getAdvisor();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1a75ff),
        title: Text(
          'YOUR ADVISOR',
          style: TextStyle(
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {

          return SingleChildScrollView(
              child: ConstrainedBox(
              constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
               ),
            child: Container(

              padding: EdgeInsets.all(15),
            decoration: BoxDecoration(


              gradient: LinearGradient(
              colors:[ Color(0xff3385ff),Color(0xff99c2ff),],
          begin:Alignment.topCenter,
          end:Alignment.bottomCenter,

          ),
          ),


             child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: height < 640 ? height * 0.2 : height * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white70.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(15)),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 1.0, // soften the shadow
                              spreadRadius: 1, //extend the shadow

                            ),

                          ],
                          gradient: LinearGradient(
                            colors:[ Color(0xffe6f0ff),Color(0xffcce0ff),],
                            begin:Alignment.bottomRight,
                            end:Alignment.topLeft,
                          ),),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Advisor',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color(0xffffffff),

                                  ),
                                ),
                                Text(
                                  '$adName',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                Text(
                                  'Advisor Code : $adCode',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: height < 640 ? height * 0.3 : height * 0.18,
                        decoration: BoxDecoration(
                          color: Colors.white70.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 1.0, // soften the shadow
                              spreadRadius: 0, //extend the shadow
                            ),
                          ],
                          gradient: LinearGradient(
                            colors:[ Color(0xffe6f0ff),Color(0xffcce0ff),],
                            begin:Alignment.bottomRight,
                            end:Alignment.topLeft,
                          ),

                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Contact your Advisor',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        '$adPhone',
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        '$adEmail',
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RatingBar(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: height < 640 ? height * 0.13 : height * 0.1,
                            width: width * 0.6,
                            child: ResponsiveTextField(
                              scrollPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              availableWidth: MediaQuery.of(context).size.width,
                              minLines: 1,
                              maxLines: 5,
                              style: TextStyle(fontSize: 16,color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20,0,0,0),
                                hintText: 'Give your feedback (Optional)',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        height: height < 640 ? height * 0.3 : height * 0.23,
                        width: width * 0.9,
                        //color: Colors.transparent.withOpacity(0.1),
                        decoration: BoxDecoration(
                          color: Colors.white70.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 1.0, // soften the shadow
                              spreadRadius: 0, //extend the shadow
                            ),
                          ],
                          gradient: LinearGradient(
                            colors:[ Color(0xffe6f0ff),Color(0xffcce0ff),],
                            begin:Alignment.bottomRight,
                            end:Alignment.topLeft,
                          ),
                        ),

                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, top: 12),
                                child: Text(
                                  'Have a question for your Advisor?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    color: Color(0xff373D3F),
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.1,
                                width: width * 0.6,
                                child: ResponsiveTextField(
                                  textAlign: TextAlign.center,
                                  availableWidth:
                                      MediaQuery.of(context).size.width,
                                  minLines: 1,
                                  maxLines: 5,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'Type your question',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.5,
                              ),
                              SizedBox(
                                height: height * 0.05,
                                width: width * 0.8,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  onPressed: () {},
                                  color: Color(0xff80aaff),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Color(0xff373D3F),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
