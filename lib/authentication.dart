import 'dart:convert';
import 'http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
////
class Authentication with ChangeNotifier {
  Future <void> signUp(String email, String password) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBpICTHbwQB60CUaItam-L_ldke5dH3xxM';
    try {
      final response = await http.post(url, body: json.encode(
          {
            'email' : email,
            'password' : password,
            'returnSecureToken' : true,

          }

      ));
      final responseData = json.decode(response.body);
      print(responseData);
      if(responseData['error'] != null)
        {
          throw HttpException(responseData['error']['message']);
        }


    }
    catch (error) {
      throw error;
    }
  }


  Future <void> logIn(String email, String password) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBpICTHbwQB60CUaItam-L_ldke5dH3xxM';
    try {
      final response = await http.post(url, body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,

          }

      ));
      final responseData = json.decode(response.body);
     //  print(responseData);

      if(responseData['error'] != null)
      {
        throw HttpException(responseData['error']['message']);
      }
    }
    catch (error) {
      throw error;
    }
  }
}
