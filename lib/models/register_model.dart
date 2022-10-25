import 'dart:convert';

class register_req_model {
  String? name;
  String? userName;
  String? email;
  String? password;
  String? confirmPassword;

  register_req_model(
      {this.name,
      this.userName,
      this.email,
      this.password,
      this.confirmPassword});

  register_req_model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['user_name'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}

class register_res_model {
  List<String>? name;
  List<String>? email;
  List<String>? non_field_errors;
  String? msg;

  register_res_model({this.name, this.email, this.msg, this.non_field_errors});

  register_res_model.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) {
      name = json['name'].cast<String>();
    }
    if (json['email'] != null) {
      email = json['email'].cast<String>();
    }
    if (json['non_field_errors'] != null) {
      non_field_errors = json['non_field_errors'].cast<String>();
    }
    if (json['msg'] != null) {
      msg = json['msg'];
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
      data['name'] = name;
    
  
      data['email'] = email;
    
    
      data['msg'] = msg;
    
   
      data['non_field_errors'] = non_field_errors;
    
      print('data');
    return data;
  }
}
