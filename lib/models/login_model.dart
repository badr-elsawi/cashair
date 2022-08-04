class LoginModel {
  late bool success;
  late String token;
  late List<Null> carts;

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    carts = [];
  }
}