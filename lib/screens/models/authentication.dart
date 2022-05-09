import 'dart:convert';

import 'package:agora/screens/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  Future<void> Signup(String email, String password) async {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA_Op1rbKUbQmgVNGuRTz5RZTVm963w4FM';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            "password": password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> LogIn(String email, String password) async {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA_Op1rbKUbQmgVNGuRTz5RZTVm963w4FM';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      print (responseData);
      if (responseData['error']!=null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }


}