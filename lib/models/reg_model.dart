class reg_req_model {
  String? name;
  String? userName;
  String? email;
  String? password;
  String? confirmPassword;

  reg_req_model(
      {this.name,
      this.userName,
      this.email,
      this.password,
      this.confirmPassword});

  reg_req_model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}

class reg_res_model {
  List<String>? userName;
  List<String>? email;
  String? msg;

  reg_res_model({this.userName, this.email, this.msg});

  reg_res_model.fromJson(Map<String, dynamic> json) {
    if (json['user_name'] != null) userName = json['user_name'].cast<String>();
    if (json['email'] != null) email = json['email'].cast<String>();
    if (json['msg'] != null) msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['user_name'] = userName;
    data['email'] = email;
    data['msg'] = msg;
    return data;
  }
}
