class login_model {
  String? email;
  String? password;

  login_model({this.email, this.password});

  login_model.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    return data;
  }
}

class login_response_model {
  String? detail;
  String? access;
  String? refresh;

  login_response_model({this.detail, this.access, this.refresh});

  login_response_model.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];

    refresh = json['refresh'];

    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    print(data);

    data['detail'] = detail;
    data['access'] = access;
    data['refresh'] = refresh;

    return data;
  }
}
