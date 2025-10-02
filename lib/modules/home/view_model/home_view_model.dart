import 'package:ayur_project/modules/home/models/patient_response_model.dart';
import 'package:ayur_project/modules/home/services/home_service.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier{
  List<Patient>? patientList;
  bool isLoading = false;

  Future<void> getPatientList() async {
    setLoader(true);
    final response = await HomeService.fetchPatientList();
    if(response == null) return;
    patientList = response.patient;
    setLoader(false);
  }

  setLoader(bool val){
    isLoading = val;
    notifyListeners();
  }

}