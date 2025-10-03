class RegisterRequestModel {
  String name;
  String executive;
  String payment;
  String phone;
  String address;
  int totalAmount;
  int discountAmount;
  int advanceAmount;
  int balanceAmount;
  String dateAndTime;
  String id;
  List<int?> male;
  List<int?> female;
  String branch;
  List<int?> treatments;

  RegisterRequestModel({
    required this.name,
    required this.executive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    this.id = "",
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "excecutive": executive,
      "payment": payment,
      "phone": phone,
      "address": address,
      "total_amount": totalAmount.toString(),
      "discount_amount": discountAmount.toString(),
      "advance_amount": advanceAmount.toString(),
      "balance_amount": balanceAmount.toString(),
      "date_nd_time": dateAndTime,
      "id": id,
      "male": male.whereType<int>().join(','),
      "female": female.whereType<int>().join(','),
      "branch": branch,
      "treatments": treatments.whereType<int>().join(','),
    };
  }
}