import 'package:finance_app/ImageData.dart';
import 'package:finance_app/setPin.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TaxFiling extends StatefulWidget {

  final String currentUserID;
  TaxFiling({Key key, @required this.currentUserID}) : super(key: key);


  final String title = "Upload Image Demo";

  @override
  _TaxFilingState createState() => _TaxFilingState();
}

class _TaxFilingState extends State<TaxFiling> {
  String currentUserID;
  _TaxFilingState({@required this.currentUserID});
  File _image ;
  final picker= ImagePicker();
  TextEditingController nameController = TextEditingController();

  Future imageChoose() async{
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }
  Future setMPin() async {
    // final uri = Uri.parse(
    //     'http://sanjayagarwal.in/Finance App/imageUpload.php');
    // var request = http.MultipartRequest('POST', uri);
    // request.fields['name'] = nameController.text;
    // // print(nameController.text);
    // var pic = await http.MultipartFile.fromPath("image", _image.path);


    var url = 'http://sanjayagarwal.in/Finance App/imageUpload.php';
    print("****************************************************");
    print(nameController.text);
    print(_image.path);
    print(currentUserID);
    print("****************************************************");
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{

        "name": nameController.text,
        "path": _image.path,
        "UserID": currentUserID,

      }),
    );
    var message = jsonDecode(response.body);
    if (message["message"] == "Successful Insertion") {
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print(currentUserID);

      print(currentUserID);
    } else {
      print(message["message"]);
    }
  }

      Future uploadImage() async
  {
    final uri = Uri.parse('http://sanjayagarwal.in/Finance App/imageUpload.php');
    var request = http.MultipartRequest('POST',uri);
    request.fields['name']= nameController.text;
   // print(nameController.text);
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    print(_image.path);
    request.files.add(pic);
    var response = await request.send();
    if(response.statusCode==200)
      {
        print('image uploaded');
      }
    else {
      print('not uploaded');
    }

  }

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name'
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                imageChoose();

              },
            ),
            Container(
              child: _image == null ?Text('No Image Selected') : Image.file(_image),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('upload'),
              onPressed: () {
                SetPin();

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ImageData(
                //           currentUserID: currentUserID,
                //         )));
              },
            )
          ],
        ),
      ),

    );
  }
}