class newpass_req_model {
  String? email;
  String? otp;
  String? passwordd;
  String? confirmPasswordd;

  newpass_req_model(
      {this.email, this.otp, this.passwordd, this.confirmPasswordd});

  newpass_req_model.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
    passwordd = json['passwordd'];
    confirmPasswordd = json['confirm_passwordd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    data['passwordd'] = passwordd;
    data['confirm_passwordd'] = confirmPasswordd;
    return data;
  }
}

class newpass_res_model {
  String? msg;

  newpass_res_model({this.msg});

  newpass_res_model.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    return data;
  }
}
