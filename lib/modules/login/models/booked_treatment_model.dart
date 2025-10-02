import 'package:ayur_project/modules/login/models/treatment_response_model.dart';

class BookedTreatmentModel{
  Treatments? treatments;
  int? maleCount;
  int? femaleCount;

  BookedTreatmentModel(this.treatments, this.maleCount, this.femaleCount);
}