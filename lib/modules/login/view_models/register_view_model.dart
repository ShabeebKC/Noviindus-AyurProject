import 'package:ayur_project/modules/login/models/booked_treatment_model.dart';
import 'package:ayur_project/modules/login/models/register_request_model.dart';
import 'package:ayur_project/modules/login/services/register_service.dart';
import 'package:ayur_project/utils/utils.dart';
import 'package:flutter/material.dart';
import '../models/branch_response_model.dart';
import '../models/treatment_response_model.dart';

class RegisterViewModel extends ChangeNotifier{
  String selectedLocation = "Calicut";
  List<String> locations = ['Calicut', 'Ernakulam', 'Thiruvananthapuram'];
  Branches? selectedBranch;
  List<Branches>? branchList;
  Treatments? selectedTreatment;
  List<Treatments>? treatmentList;
  String? selectedPaymentOption = "Cash";
  List<String> paymentOptions = ["Cash", "Card", "UPI"];
  int maleCount = 0;
  int femaleCount = 0;
  List<BookedTreatmentModel> bookedTreatments = [];
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  bool isLoading = false;

  void getBranches() async {
    await RegisterService.fetchBranches().then((value) {
      if(value == null || (value.branches?.isEmpty ?? true)) return;
      branchList = value.branches;
    });
  }

  void getTreatments() async {
    await RegisterService.fetchTreatments().then((value) {
      if(value == null || (value.treatments?.isEmpty ?? true)) return;
      treatmentList = value.treatments;
    });
  }

  void changeLocation(String val){
    selectedLocation = val;
    notifyListeners();
  }

  void changeBranch(Branches? val){
    selectedBranch = val;
    notifyListeners();
  }

  void changeTreatment(Treatments? val){
    selectedTreatment = val;
    notifyListeners();
  }

  void changePaymentOption(String? val){
    selectedPaymentOption = val;
    notifyListeners();
  }

  void modifyPatientCount(String gender, String operator) {
    if (gender == "Male") {
      maleCount = operator == "+" ? maleCount + 1 : maleCount - 1;
    } else {
      femaleCount = operator == "+" ? femaleCount + 1 : femaleCount - 1;
    }
    notifyListeners();
  }

  addTreatment(BookedTreatmentModel treatment){
    bookedTreatments.add(treatment);
    notifyListeners();
  }

  removeTreatment(int index){
    bookedTreatments.removeAt(index);
    notifyListeners();
  }

  updateTime(TimeOfDay val){
    time = val;
    notifyListeners();
  }

  updateDate(DateTime val){
    date = val;
    notifyListeners();
  }

  setLoader(bool val){
    isLoading = val;
    notifyListeners();
  }


  Future<void> registerPatient(String name, String whNumber, String address, (String, String, String, String) amounts) async {
    setLoader(true);
    final total = double.tryParse(amounts.$1) ?? 0;
    final discount = double.tryParse(amounts.$2) ?? 0;
    final advance = double.tryParse(amounts.$3) ?? 0;
    final balance = double.tryParse(amounts.$4) ?? 0;

    final maleBuffer = StringBuffer();
    final femaleBuffer = StringBuffer();
    final treatmentBuffer = StringBuffer();
    for (final item in bookedTreatments) {
      maleBuffer.write("${item.maleCount},");
      femaleBuffer.write("${item.femaleCount},");
      treatmentBuffer.write("${item.treatments?.id},");
    }
    final totalMaleCount = maleBuffer.toString();
    final totalFemaleCount = femaleBuffer.toString();
    final treatmentIds = treatmentBuffer.toString();

    final request = RegisterRequestModel(
        name: name,
        executive: selectedLocation,
        payment: selectedPaymentOption ?? "",
        phone: whNumber,
        address: address,
        totalAmount: total,
        discountAmount: discount,
        advanceAmount: advance,
        balanceAmount: balance,
        dateAndTime: "${Utils.formatDate(date.toString())}-${Utils.formatTime(time)}",
        male: totalMaleCount,
        female: totalFemaleCount,
        branch: selectedBranch?.id.toString() ?? "",
        treatments: treatmentIds
    );
    await RegisterService.registerPatient(request).then((value) {
      setLoader(false);
      if(value == null) return;
    });
  }
}