class RegisterModel {
  int? id;
  String? token;
  String? error;

  RegisterModel({this.id, this.token, this.error});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    data['error'] = error;
    return data;
  }
}
