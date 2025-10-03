import 'package:ayur_project/modules/home/models/patient_response_model.dart';
import 'package:ayur_project/modules/home/services/home_service.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier{
  List<Patient>? patientList;
  List<Patient> searchedList= [];
  bool isLoading = false;
  bool isAscending = false;

  Future<void> getPatientList() async {
    setLoader(true);
    final response = await HomeService.fetchPatientList();
    if(response == null || (response.patient?.isEmpty ?? true)) return;
    patientList = response.patient;
    setLoader(false);
  }

  void sortPatientsByDate(bool order) {
    isAscending = order;
    notifyListeners();
    patientList?.sort((a, b) {
      final dateA = DateTime.tryParse(a.createdAt ?? '') ?? DateTime(0);
      final dateB = DateTime.tryParse(b.createdAt ?? '') ?? DateTime(0);
      return isAscending ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });
    notifyListeners();
  }

  void renderSearch(String enteredKeyword) {
    searchedList.clear();
    if (enteredKeyword.isEmpty) {
      notifyListeners();
      return;
    } else {
      patientList?.forEach((element) {
        if (element.patientDetailsSet?.isNotEmpty == true &&
            element.patientDetailsSet!.first.treatmentName.toString().toLowerCase().contains(enteredKeyword.toLowerCase())) {
          searchedList.add(element);
        }
      });
    }
    notifyListeners();
  }

  setLoader(bool val){
    isLoading = val;
    notifyListeners();
  }

}