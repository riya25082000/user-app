import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_text_field/responsive_text_field.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdvisorPage extends StatefulWidget {
  final String currentUserID;
  AdvisorPage({@required this.currentUserID});
  @override
  _AdvisorPageState createState() =>
      _AdvisorPageState(currentUserID: currentUserID);
}

class _AdvisorPageState extends State<AdvisorPage> {
  final String currentUserID;
  _AdvisorPageState({@required this.currentUserID});
  String adName = '';
  String adCode = '';
  String adEmail = '';
  String adPhone = '';
  void getAdvisor() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/Advisor/AdvisorOfUser.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": widget.currentUserID,
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message[0]);
    print("****************************************");
    var url1 =
        'http://sanjayagarwal.in/Finance App/UserApp/Advisor/AdvisorPartDetails.php';
    final response1 = await http.post(
      url1,
      body: jsonEncode(<String, String>{
        "AdvisorID": message[0]['AdvAlloted'],
      }),
    );
    var message1 = await jsonDecode(response1.body);
    print("****************************************");
    print(message1);
    print("****************************************");
    setState(() {
      adEmail = message1[0]['Email'];
      adName = message1[0]['Name'];
      adPhone = message1[0]['Mobile'];
      adCode = message1[0]['AdvisorID'];
    });
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
        backgroundColor: Color(0xff63E2E0),
        title: Text(
          'YOUR ADVISOR',
          style: TextStyle(
            color: Color(0xff373D3F),
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: height < 640 ? height * 0.2 : height * 0.15,
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
                                  color: Color(0xff373D3F),
                                ),
                              ),
                              Text(
                                '$adName',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff373D3F),
                                ),
                              ),
                              Text(
                                'Advisor Code : $adCode',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff373D3F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      height: height < 640 ? height * 0.3 : height * 0.18,
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
                                    color: Color(0xff373D3F),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '$adPhone',
                                      style: TextStyle(
                                        color: Color(0xff373D3F),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.mail,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '$adEmail',
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        color: Color(0xff373D3F),
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
                    Divider(
                      color: Colors.grey,
                    ),
                    RatingBar(
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
                    Container(
                      height: height < 640 ? height * 0.13 : height * 0.05,
                      width: width * 0.6,
                      child: ResponsiveTextField(
                        textAlign: TextAlign.center,
                        availableWidth: MediaQuery.of(context).size.width,
                        minLines: 1,
                        maxLines: 5,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Give your feedback (Optional)',
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      color: Color(0xff63E2E0),
                      child: Text("Send feedback"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      height: height < 640 ? height * 0.3 : height * 0.23,
                      width: width * 0.9,
                      color: Colors.white,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 12),
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
                                color: Color(0xff63E2E0),
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
