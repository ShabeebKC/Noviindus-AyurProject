import 'dart:convert';
import 'dart:developer';
import 'package:ayur_project/modules/login/models/register_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../constants/api_urls.dart';
import '../../../constants/app_configs.dart';
import '../models/branch_response_model.dart';
import '../models/treatment_response_model.dart';

class RegisterService{
  static Future<BranchResponseModel?> fetchBranches() async {
    final response = await http.get(
        Uri.parse(ApiUrls.branchList),
        headers: AppConfigs.headers
    );
    debugPrint("BranchList Response status code : ${response.statusCode}");
    debugPrint("BranchList Response: ${response.body.toString()}");
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return BranchResponseModel.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("BranchList Response status code : ${response.statusCode}");
    }else {
      return null;
    }
    return null;
  }

  static Future<TreatmentResponseModel?> fetchTreatments() async {
    final response = await http.get(
        Uri.parse(ApiUrls.treatmentList),
        headers: AppConfigs.headers
    );
    debugPrint("TreatmentList Response status code : ${response.statusCode}");
    debugPrint("TreatmentList Response: ${response.body.toString()}");
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return TreatmentResponseModel.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("TreatmentList Response status code : ${response.statusCode}");
    }else {
      return null;
    }
    return null;
  }

  static Future<dynamic> registerPatient(RegisterRequestModel request) async {
    log(request.toJson().toString());
    final response = await http.post(
        body: jsonEncode(request.toJson()),
        headers: {
          'Authorization': 'Bearer ${AppConfigs.appToken}',
        },
        Uri.parse(ApiUrls.registerPatient),
    );
    debugPrint("RegisterPatient Response status code : ${response.statusCode}");
    log("RegisterPatient Response: ${response.body.toString()}");
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return TreatmentResponseModel.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("RegisterPatient Response status code : ${response.statusCode}");
    }else {
      return null;
    }
    return null;
  }
}