import 'dart:io';

class Profile_details_req {
  String? name;
  String? userName;
  File? picture;
  String? gender;
  String? dateOfBirth;
  int? mobile;
  bool? isEducator;

  Profile_details_req(
      {this.name,
      this.userName,
      this.picture,
      this.gender,
      this.dateOfBirth,
      this.mobile,
      this.isEducator});

  Profile_details_req.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
    picture = json['picture'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    mobile = json['mobile'];
    isEducator = json['is_educator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['picture'] = this.picture;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['mobile'] = this.mobile;
    data['is_educator'] = this.isEducator;
    return data;
  }
}

class Profile_details_res {
  String? message;

  Profile_details_res({this.message});

  Profile_details_res.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
