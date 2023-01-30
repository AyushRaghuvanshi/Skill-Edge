import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/Stores/home.dart';
import 'package:skilledge/models/forgot_pass.dart';
import 'package:skilledge/models/interest_model.dart';
import 'package:skilledge/models/login_model.dart';
import 'package:skilledge/models/newpass.dart';
import 'package:skilledge/models/otp_model.dart';
import 'package:skilledge/models/profile_details_model.dart';
import 'package:skilledge/models/reg_model.dart';
import 'package:skilledge/models/resendotp.dart';
import 'package:skilledge/screens/dashboard.dart';

String? token;

class API {
  Dio dio = new Dio();
  var home = Home();

  bool? ayush;

  // dio.options.headers["Authorization"] = "Bearer ${token}";
  Future<login_response_model> login_api(login_model req) async {
    String url = "https://skilledge-backend.suhailahmad4.repl.co/api/login/";
    ayush = true;
    log("hit");
    final res = await dio.post((url), data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    print(res.statusCode.toString());
    ayush = false;
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      if (login_response_model.fromJson((res.data)).token !=
          null) if (login_response_model
              .fromJson((res.data))
              .token["access"] !=
          null) {
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
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/new_user_registration/";
    ayush = true;
    FormData data = FormData.fromMap({
      "name": req.name,
      "user_name": req.userName,
      "email": req.email,
      "password": req.password
    });
    final res = await dio.post(url, data: {
      "email": req.email,
      "name": req.name,
      "user_name": req.userName,
      "password": req.password
    }, options: Options(
      validateStatus: (status) {
        return true;
      },
    ));
    ayush = false;
    print((data).toString());
    print(res.data);
    if (res.statusCode == 200 || res.statusCode == 400) {
      return reg_res_model.fromJson(((res.data)));
    } else {
      throw Exception('Error occured while loading data');
    }
  }

  Future<otp_res_model> verifyotp(OTP_req_model req) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/otp_verify/";
    final res = await dio.post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    ayush = false;

    if (res.statusCode == 200 || res.statusCode == 400) {
      if (res.data['token'] != null) {
        token = res.data['token']["access"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token!);
      }
      return otp_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<newpass_res_model> newpass(newpass_req_model req) async {
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/enter_new_password/";
    ayush = true;
    final res = await dio.post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    ayush = false;

    if (res.statusCode == 200 || res.statusCode == 400) {
      return newpass_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<forgot_res_model> forgot(forgot_req_model req) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/reset_password/";
    final res = await dio.post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    ayush = false;
    if (res.statusCode == 200 || res.statusCode == 400) {
      return forgot_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<resendotp_res_model> resendotp(resendotp_req_model req) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/resend_otp/";
    final res = await dio.post(url, data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    ayush = false;

    if (res.statusCode == 200 || res.statusCode == 400) {
      return resendotp_res_model.fromJson((res.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Profile_details_res> profile(Profile_details_req req) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/profile_details/";
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
    ayush = false;
    print(res.data);
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
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/rate_course/";
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
    ayush = false;
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
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/view_specific_lesson/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    FormData data = FormData.fromMap({
      "topic": topiId,
    });
    final res = await dio.post((url), data: data, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 405;
      },
    ));
    print(topiId);
    (topiId);
    ayush = false;
    print(res.data.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> verifycheck() async {
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/Verifycheck/";
    ayush = true;
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 405;
      },
    ));
    print(res.statusCode);
    ayush = false;
    if (res.statusCode == 400) {
      return false;
    } else if (res.statusCode == 200) {
      return true;
    }

    if (res.statusCode == 200 || res.statusCode == 401) {
      return false;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> getUserReviews(int cid) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/user_course_feedback/$cid/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get(url, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 405;
      },
    ));
    print(res.data);
    if (res.statusCode == 400) {
      return false;
    }
    ayush = false;
    if (res.statusCode == 200) {
      return res.data[0];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getReviews(int cid) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/course_feedback/${cid}/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get(url, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 405;
      },
    ));
    print(res.data);
    (res.toString());
    ayush = false;
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> getprofile() async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/api/profile_details/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    ayush = false;

    print(res.toString());
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
        await value.setBool("is_educator", res.data['is_educator']);
        await value.setBool(
            "is_certified_educator", res.data['is_certified_educator']);
        await value.setDouble("educator_rating", res.data['educator_rating']);
        await getcourses();
        await gethostedCourses();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> gethostedCourses() async {
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/educator/become_educator/";
    ayush = true;
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));

    ayush = false;
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      SharedPreferences.getInstance().then((value) async {
        int n = res.data.length;
        var list = res.data;
        List<String> temp = [];

        for (int i = 0; i < n; i++) {
          String s = json.encode(list[i]);
          temp.add(s);
        }
        await value.setStringList("hostedCourses", temp);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getCart() async {
    ayush = true;
    String url = "https://skilledge-backend.suhailahmad4.repl.co/cart/cart/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    ayush = false;
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
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/view_filtered_courses/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    ayush = false;

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
    // ayush = true;
    String url = "";
    print(search);
    (filter);
    if (filter == -1) {
      url =
          "https://skilledge-backend.suhailahmad4.repl.co/courses/search_course/?search-area=${search}";
    } else {
      url =
          "https://skilledge-backend.suhailahmad4.repl.co/courses/search_course/?search-area=$search&category=$filter";
    }
    print(url);

    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    // ayush = false;
    if (res.statusCode == 400) {
      return ['Nothing Found Here'];
    }
    print(res.data);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> buyacourse(int cid) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/wallet/buy_course/" +
            cid.toString() +
            '/';

    print(url);
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.put((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    ayush = false;
    if (res.statusCode == 400) {
      return res.data['msg'];
    }

    if (res.statusCode == 200) {
      return 'Course Purchased\n Money in Wallet Left: ' +
          res.data['wallet'].toString();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getpurchasedcourses() async {
    // ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/purchased_courses/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    (token);
    (res.data);
    // ayush = false;
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> buyallcourse() async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/wallet/buy_allcourses/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.put((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    (token);
    print(res.data);
    ayush = false;
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Interest_res> interest(Interest_req req) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/category/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.put((url), data: req.toJson(), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400;
      },
    ));
    ayush = false;
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
    ayush = true;
    String url = "https://skilledge-backend.suhailahmad4.repl.co/cart/cart/" +
        cid.toString() +
        '/';
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.delete((url), options: Options(
      validateStatus: (status) {
        return true;
      },
    ));
    (res.data);
    ayush = false;

    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data["msg"];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> addbalancewallet(int amount, String paymentid) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/payment/flutter_razorpay/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    print(amount);
    final res = await dio.post((url), data: {
      "order_amount": (amount / 100).floor(),
      "order_payment_id": paymentid
    }, options: Options(
      validateStatus: (status) {
        return true;
      },
    ));

    ayush = false;
    if (res.statusCode == 400) {
      return 'Not Enough Balance in your Wallet';
    }
    if (res.statusCode == 200 || res.statusCode == 401) {
      return 'Redeeming Successful, Check Your Account';
    } else {
      print(res.data);
      throw Exception('Failed to load data');
    }
  }

  Future<double> getwalletmoney() async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/wallet/buy_allcourses/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    final res = await dio.get((url), options: Options(
      validateStatus: (status) {
        return true;
      },
    ));
    ayush = false;
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> addtoCart(int cid) async {
    ayush = true;
    String url = "https://skilledge-backend.suhailahmad4.repl.co/cart/cart/";
    dio.options.headers["Authorization"] = "Bearer ${token}";

    final res = await dio.put((url), data: {"course": cid}, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    ayush = false;
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data["msg"];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> hostCourse(File thumbnail, String desc, String price,
      String topic, String lessonName, File video, int catog) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/course/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    FormData data = FormData.fromMap({
      "category": catog,
      "topic": topic,
      "price": price,
      "short_description": desc,
      "thumbnail": await MultipartFile.fromFile(
        thumbnail.path,
        filename: thumbnail.path.split('/').last,
        contentType: new MediaType("image", "jpg"),
      ),
    });
    final res = await dio.post((url), data: data, options: Options(
      validateStatus: (status) {
        return true;
      },
    ));
    ayush = false;
    // print(res.data);
    log(res.toString());
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return await addLesson((res.data['id']), lessonName, video);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> addLesson(int cid, String desc, File file) async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/courses/lesson/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    FormData data = FormData.fromMap({
      "topic": cid,
      "lessonName": desc,
      "file": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        // contentType: new MediaType("video", "mp4"),
      ),
    });
    final res = await dio.post((url), data: data, options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    ayush = false;
    // print(res.data);
    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
      return res.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> makeEdu() async {
    ayush = true;
    String url =
        "https://skilledge-backend.suhailahmad4.repl.co/educator/become_educator/";
    dio.options.headers["Authorization"] = "Bearer ${token}";
    // FormData data = FormData.fromMap({
    //   "topic": cid,
    //   "description": desc,
    //   "picture": await MultipartFile.fromFile(
    //     file.path,
    //     filename: file.path.split('/').last,
    //     contentType: new MediaType("video", "mp4"),
    //   ),
    // });
    final res = await dio.put((url), options: Options(
      validateStatus: (status) {
        return status == 200 || status == 400 || status == 401;
      },
    ));
    ayush = false;

    if (res.statusCode == 200 ||
        res.statusCode == 400 ||
        res.statusCode == 401) {
    } else {
      throw Exception('Failed to load data');
    }
  }
}
