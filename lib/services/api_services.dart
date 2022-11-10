import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/models/forgot_pass.dart';
import 'package:skilledge/models/interest_model.dart';
import 'package:skilledge/models/login_model.dart';
import 'package:skilledge/models/newpass.dart';
import 'package:skilledge/models/otp_model.dart';
import 'package:skilledge/models/profile_details_model.dart';
import 'package:skilledge/models/reg_model.dart';
import 'package:skilledge/models/resendotp.dart';

String? token;

class API {
  Dio dio = new Dio();

  // dio.options.headers["Authorization"] = "Bearer ${token}";
  Future<login_response_model> login_api(login_model req) async {
    String url = "https://skilledge.herokuapp.com/api/login/";
    final res = await dio.post((url), data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    (res.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      if (login_response_model.fromJson((res.data)).token["access"] != null) {
        token = login_response_model.fromJson((res.data)).token["access"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token!);
        await getprofile();
      }
      (token);
      return login_response_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<reg_res_model> reg_api(reg_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/new_user_registration/";
    final res = await dio.post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));

    if (res.statusCode == 200 || res.statusCode == 400) {
      if (reg_res_model.fromJson(((res.data))).token != null) {
        token = reg_res_model.fromJson(((res.data))).token["access"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token!);
      }
      (token);
      return reg_res_model.fromJson(((res.data)));
    } else {
      throw Exception('Error occured while loading data');
    }
  }

  Future<otp_res_model> verifyotp(OTP_req_model req) async {
    String url = "https://skilledge.herokuapp.com/api/otp_verify/";
    final res = await dio.post(url, data: req.toJson(), options: Options(
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
    final res = await dio.post(url, data: req.toJson(), options: Options(
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
    final res = await dio.post(url, data: req.toJson(), options: Options(
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
    final res = await dio.post(url, data: req.toJson(), options: Options(
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

  Future<Profile_details_res> profile(Profile_details_req req) async {
    String url = "https://skilledge.herokuapp.com/api/profile_details/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    FormData data;
    if (req.picture != null) {
      data = FormData.fromMap({
        "name": req.name,
        "dateOfBirth": req.dateOfBirth,
        "user_name": req.userName,
        "gender": req.gender,
        "mobile": req.mobile,
        "is_educator": req.isEducator,
        "picture": await MultipartFile.fromFile(
          req.picture!.path,
          filename: req.picture!.path.split('/').last,
          contentType: new MediaType("image", "jpg"),
        ),
      });
    } else {
      data = FormData.fromMap({
        "name": req.name,
        "dateOfBirth": req.dateOfBirth,
        "user_name": req.userName,
        "gender": req.gender,
        "mobile": req.mobile,
        "is_educator": req.isEducator,
      });
    }
    final res = await dio.put((url), data: data, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      (res.data);
      return Profile_details_res.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> addReview(int cid, String comment, int rating) async {
    String url = "https://skilledge.herokuapp.com/courses/rate_course/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    FormData data;

    data = FormData.fromMap({
      "course": cid.toString(),
      "latest_review": rating.toString(),
      "comment": comment
    });

    final res = await dio.post((url), data: data, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    (res.data);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      (res.data);
      return res.data['msg'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getLessons(int topiId) async {
    String url =
        "https://skilledge.herokuapp.com/courses/view_specific_lesson/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    FormData data = FormData.fromMap({
      "topic": topiId,
    });
    final res = await dio.post((url), data: data, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 405;
      },
    ));
    (topiId);
    (res.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getReviews(int cid) async {
    String url =
        "https://skilledge.herokuapp.com/courses/course_feedback/${cid}/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get(url, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 405;
      },
    ));
    (res.data);
    (res.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> getprofile() async {
    String url = "https://skilledge.herokuapp.com/api/profile_details/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));

    (res.data);
    (res.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      SharedPreferences.getInstance().then((value) async {
        await value.setString("Name", res.data['name']);
        await value.setString("Username", res.data['user_name']);
        await value.setString("picture", res.data['picture']);
        await value.setString("dateOfBirth", res.data['dateOfBirth']);
        await value.setInt("mobile", res.data['mobile']);
        await value.setString("gender", res.data['gender']);
        // await value.setString("email", res.data['email']);
        await value.setBool("is_educator", res.data['is_educator']);
        await getcourses();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getCart() async {
    String url = "https://skilledge.herokuapp.com/cart/viewcart/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    if (res.statusCode == 400) {
      return [res.data['msg']];
    }

    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> getcourses() async {
    String url =
        "https://skilledge.herokuapp.com/courses/view_filtered_courses/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));

    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      SharedPreferences.getInstance().then((value) async {
        int n = res.data['count'];
        var list = res.data['results'];
        List<String> temp = [];
        if (n > 10) {
          n = 10;
        }
        for (int i = 0; i < n; i++) {
          String s = json.encode(list[i]);
          temp.add(s);
        }
        await value.setStringList("Courses", temp);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getSearchresults(String search, int filter) async {
    String url = "";
    (filter);
    if (filter == -1) {
      url =
          "https://skilledge.herokuapp.com/courses/search_course/?search-area=$search" +
              search.trim();
    } else {
      url =
          "https://skilledge.herokuapp.com/courses/search_course/?search-area=$search&category=$filter";
    }
    (url);
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    (res.statusCode);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getpurchasedcourses() async {
    String url = "https://skilledge.herokuapp.com/courses/purchased_courses/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    (token);
    (res.data);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Interest_res> interest(Interest_req req) async {
    String url = "https://skilledge.herokuapp.com/courses/add_category/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.put((url), data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    ('It is=>');
    (res.data);

    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      await getprofile();
      return Interest_res.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> removefromCart(int cid) async {
    String url = "https://skilledge.herokuapp.com/cart/remove_from_cart/" +
        cid.toString() +
        '/';
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.delete((url), options: Options(
      validateStatus: (status) {
        return true;
      },
    ));
    (res.data);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data["msg"];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> addtoCart(int cid) async {
    String url = "https://skilledge.herokuapp.com/cart/add_to_cart/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.put((url), data: {"course": cid}, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data["msg"];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
