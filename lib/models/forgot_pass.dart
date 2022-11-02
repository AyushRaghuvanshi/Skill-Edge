class forgot_req_model {
  String? email;

  forgot_req_model({this.email});

  forgot_req_model.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;

    return data;
  }
}

class forgot_res_model {
  String? msg;

  forgot_res_model({this.msg});

  forgot_res_model.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    return data;
  }
}
