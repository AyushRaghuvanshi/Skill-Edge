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
    data['email'] = this.email;
    data['otp'] = this.otp;
    return data;
  }
}