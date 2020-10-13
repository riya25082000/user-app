import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/ImageData.dart';
import 'package:finance_app/setPin.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class ImageData extends StatefulWidget {
  final String currentUserID;
  ImageData({Key key, @required this.currentUserID}) : super(key: key);
  @override
  _ImageDataState createState() => _ImageDataState(currentUserID: currentUserID);
}

class _ImageDataState extends State<ImageData> {
  String currentUserID;
  _ImageDataState({@required this.currentUserID});
  final String phpEndPoint = 'http://sanjayagarwal.in/Finance App/imageUpload.php';
  final String nodeEndPoint = 'http://192.168.43.171:3000/image';
  File file;
  File _image ;

  void _choose() async {
    //file = await ImagePicker.pickImage(source: ImageSource.camera);
file = await ImagePicker.pickImage(source: ImageSource.gallery);
setState(() {
  _image=File(file.path);
});
  }

  void _upload() async {


    print(currentUserID);

    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;
    print(fileName);
    print(base64Image);

    final response = await http.post(
        phpEndPoint, body:jsonEncode(<String, String> {
      "image": base64Image,
      "name": fileName,
      "userid":currentUserID
    }),
    );
    var message = jsonDecode(response.body);
    if (message["message"] == "Successful Insertion") {
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Image Updated Successful"),
            content: Text("Your image has been updated successfully."),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                },
                child: Text("Ok"),
              )
            ],
          );
        },
      );
      print(currentUserID);
    } else {
      print(message["message"]);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _choose,
                child: Text('Choose Image'),
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: _upload,
                child: Text('Upload Image'),
              )
            ],
          ),
          file == null
              ? Text('No Image Selected')
              : Image.file(file)
        ],
      ),
    );
  }
}
