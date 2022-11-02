import 'package:dio/dio.dart';
import 'package:skilledge/models/forgot_pass.dart';
import 'package:skilledge/models/login_model.dart';
import 'package:skilledge/models/newpass.dart';
import 'package:skilledge/models/otp_model.dart';
import 'package:skilledge/models/reg_model.dart';
import 'package:skilledge/models/resendotp.dart';

class API {
  Future<login_response_model> login_api(login_model req) async {
    String url = "https://skilledge.herokuapp.com/api/login/";

    final res = await Dio().post((url), data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    print(res.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return login_response_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<reg_res_model> reg_api(reg_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/new_user_registration/";

    final res = await Dio().post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));

    if (res.statusCode == 200 || res.statusCode == 400) {
      return reg_res_model.fromJson(((res.data)));
    } else {
      throw Exception('Error occured while loading data');
    }
  }

  Future<otp_res_model> verifyotp(OTP_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/otp_verify/";
    final res = await Dio().post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));

    if (res.statusCode == 200 || res.statusCode == 400) {
      return otp_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<newpass_res_model> newpass(newpass_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/enter_new_password/";
    final res = await Dio().post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));

    if (res.statusCode == 200 || res.statusCode == 400) {
      return newpass_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<forgot_res_model> forgot(forgot_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/reset_password/";
    final res = await Dio().post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));

    if (res.statusCode == 200 || res.statusCode == 400) {
      return forgot_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<resendotp_res_model> resendotp(resendotp_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/resend_otp/";
    final res = await Dio().post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));

    if (res.statusCode == 200 || res.statusCode == 400) {
      return resendotp_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
