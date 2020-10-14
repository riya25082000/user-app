
//hey
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class Tax_flling_now extends StatefulWidget {
  final String currentUserId;
  Tax_flling_now({Key key, @required this.currentUserId}) : super(key: key);
  @override
  State createState() => _Tax_flling_now();
}

class _Tax_flling_now extends State<Tax_flling_now> {
  FileImage _image;
  @override
  Future _getImage() async{
    var image=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image=image as FileImage;
      print('_image: $_image');
    });
  }
  Widget build(BuildContext context) {

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
          'TAX FILLING PAGE',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context,
              BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),

                            color: Color(0xfffffff),
                            alignment: Alignment.centerLeft,
                            child: Text("",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff373D3F),
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(10),

                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: Color(0xfffffff).withOpacity(0.9),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,

                                    hintText: 'Text 1'

                                ),
                                onSubmitted: (String str) {

                                },
                              )
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.all(10),

                            child: Text("",
                                style: TextStyle(
                                  color: Color(0xff373D3F),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                )
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(10),

                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: Color(0xfffffff).withOpacity(0.9),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,

                                    hintText: 'Text 2'

                                ),
                                onSubmitted: (String str) {

                                },
                              )
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.all(10),

                            child: Text("",
                                style: TextStyle(
                                  color: Color(0xff373D3F),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                          ),


                          Container(

                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Color(0xfffffff).withOpacity(0.9),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,

                                  hintText: 'Text 3'

                              ),
                              onSubmitted: (String str) {

                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left:50,top: 5,bottom: 5,right: 50),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: RaisedButton(
                                    child: Text('Add Image',textAlign: TextAlign.center,),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    onPressed: _getImage,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: RaisedButton(
                                    child: Text('Add Image',textAlign: TextAlign.center,),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    onPressed: _getImage,
                                    color: Colors.white,
                                  ),
                                )
                              ],

                            ),
                          ),
                        ]))
            );
          }),);
  }
}
