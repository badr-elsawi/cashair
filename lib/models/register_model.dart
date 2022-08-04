class RegisterModel {
  late bool success;
  late String status;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
  }
}