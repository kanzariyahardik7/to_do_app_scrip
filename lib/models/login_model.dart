class LoginModel {
  String? token;
  String? error;
  LoginModel({this.token, this.error});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (error != null) data['error'] = error;
    return data;
  }
}
