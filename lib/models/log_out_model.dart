class LogoutModel {
  late bool success;
  late String status;

  LogoutModel.fromJson(Map<String,dynamic> json){
    success = json['success'];
    status = json['status'];
  }
}