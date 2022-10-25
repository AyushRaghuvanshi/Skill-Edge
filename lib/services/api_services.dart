import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skilledge/models/login_model.dart';
import 'package:skilledge/models/register_model.dart';

class API {
  Future<login_response_model> login_api(login_model req) async {
    String url = "https://skilledge.herokuapp.com/api/token/";
    print(req.toJson());
    // print('here');
    final res = await http.post(Uri.parse(url), body: req.toJson());
    print(res.statusCode);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return login_response_model.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<register_res_model> reg_api(register_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/new_user_registration/";

    var obj = {
      "name": req.name,
      "user_name": req.userName,
      "email": req.email,
      "password": req.password,
      "confirm_password": req.confirmPassword
    };

    final res = await http.post(Uri.parse(url), body: obj);
    print(res.statusCode);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return register_res_model.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<register_res_model> verifyotp(register_req_model req) async {
  //   String url = "https://skilledge.herokuapp.com/api/new_user_registration/";
  //   final res = await http.post(Uri.parse(url), body: req.toJson());

  //   if (res.statusCode == 200 || res.statusCode == 400) {
  //     return register_res_model.fromJson(json.decode(res.body));
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
}
