class Interest_req {
  String? interest1;
  String? interest2;
  String? interest3;
  String? interest4;
  String? interest5;
  String? interest6;
  String? interest7;
  String? interest8;
  String? interest9;
  String? interest10;
  String? interest11;

  Interest_req(
      {this.interest1,
      this.interest2,
      this.interest3,
      this.interest4,
      this.interest5,
      this.interest6,
      this.interest7,
      this.interest8,
      this.interest9,
      this.interest10,
      this.interest11});

  Interest_req.fromJson(Map<String, dynamic> json) {
    interest1 = json['Interest1'];
    interest2 = json['Interest2'];
    interest3 = json['Interest3'];
    interest4 = json['Interest4'];
    interest5 = json['Interest5'];
    interest6 = json['Interest6'];
    interest7 = json['Interest7'];
    interest8 = json['Interest8'];
    interest9 = json['Interest9'];
    interest10 = json['Interest10'];
    interest11 = json['Interest11'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Interest1'] = this.interest1;
    data['Interest2'] = this.interest2;
    data['Interest3'] = this.interest3;
    data['Interest4'] = this.interest4;
    data['Interest5'] = this.interest5;
    data['Interest6'] = this.interest6;
    data['Interest7'] = this.interest7;
    data['Interest8'] = this.interest8;
    data['Interest9'] = this.interest9;
    data['Interest10'] = this.interest10;
    data['Interest11'] = this.interest11;
    return data;
  }
}

class Interest_res {
  String? msg;

  Interest_res({this.msg});

  Interest_res.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}
