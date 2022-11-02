class OTP_req_model {
  String? email;
  String? otp;

  OTP_req_model({this.email, this.otp});

  OTP_req_model.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }
}

class otp_res_model {
  String? msg;

  otp_res_model({this.msg});

  otp_res_model.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    return data;
  }
}
