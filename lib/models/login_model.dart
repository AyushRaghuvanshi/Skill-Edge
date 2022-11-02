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
  String? msg;
  int? id;
  var token;

  login_response_model({
    this.msg,
    this.id,
    this.token,
  });

  login_response_model.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    print(data);
    data['id'] = id;
    data['msg'] = msg;
    data['token'] = token;

    return data;
  }
}
