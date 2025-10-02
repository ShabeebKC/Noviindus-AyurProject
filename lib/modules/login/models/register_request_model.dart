class RegisterRequestModel {
  String name;
  String executive;
  String payment;
  String phone;
  String address;
  double totalAmount;
  double discountAmount;
  double advanceAmount;
  double balanceAmount;
  String dateAndTime;
  String id;
  String male;
  String female;
  String branch;
  String treatments;

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
      "total_amount": totalAmount,
      "discount_amount": discountAmount,
      "advance_amount": advanceAmount,
      "balance_amount": balanceAmount,
      "date_nd_time": dateAndTime,
      "id": id,
      "male": male,
      "female": female,
      "branch": branch,
      "treatments": treatments,
    };
  }
}