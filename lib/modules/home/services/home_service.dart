import 'dart:convert';
import 'dart:developer';
import 'package:ayur_project/constants/api_urls.dart';
import 'package:ayur_project/constants/app_configs.dart';
import 'package:ayur_project/modules/home/models/patient_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HomeService{
  static Future<PatientResponseModel?> fetchPatientList() async {

    final response = await http.get(
      Uri.parse(ApiUrls.patientList),
      headers: AppConfigs.headers
    );
    debugPrint("PatientList Response status code : ${response.statusCode}");
    log("PatientList Response: ${response.body.toString()}");
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return PatientResponseModel.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("PatientList Response status code : ${response.statusCode}");
    }else {
      return null;
    }
    return null;
  }
}