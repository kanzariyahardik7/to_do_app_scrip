class UserListModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserModel>? data;
  Support? support;
  String? error;

  UserListModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
    this.error,
  });

  UserListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data!.add(UserModel.fromJson(v));
      });
    }
    support = json['support'] != null
        ? Support.fromJson(json['support'])
        : null;

    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserModel({this.id, this.email, this.firstName, this.lastName, this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}

class SingleUserModel {
  UserModel? data;
  Support? support;
  String? error;

  SingleUserModel({this.data, this.support, this.error});

  SingleUserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    support = json['support'] != null
        ? Support.fromJson(json['support'])
        : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    data['error'] = error;
    return data;
  }
}
