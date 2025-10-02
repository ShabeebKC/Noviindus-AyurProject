import 'dart:convert';
import 'dart:developer';
import 'package:ayur_project/constants/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/login_response_model.dart';

class LoginService{
  static Future<LoginResponseModel?> login(String username, String password) async {
    final Map<String, String> body = {
      "username" : username,
      "password" : password
    };
    debugPrint("Login Request : $body");
    var response = await http.post(
      body: body,
      Uri.parse(ApiUrls.loginUrl),
    );
    debugPrint("Login Response status code : ${response.statusCode}");
    log("Login Response: ${response.body.toString()}");
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return LoginResponseModel.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("Login Response status code : ${response.statusCode}");
    }else {
      return null;
    }
    return null;
  }

}