import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/screens/OnboardingUI/onBoardingInterest.dart';
import 'package:skilledge/widgets/logo.dart';

class OnboardingQA extends StatefulWidget {
  const OnboardingQA(
      {super.key, this.fullName, this.email, this.userName, this.edu});
  final edu;
  final fullName;
  final email;
  final userName;
  @override
  State<OnboardingQA> createState() => _OnboardingQAState();
}

class _OnboardingQAState extends State<OnboardingQA> {
  final countryPicker = const FlCountryCodePicker();

  int? id;
  var file;
  String? dob;

  String? phone;

  var gender;

  CountryCode? countrycode;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              id = snapshot.data!.getInt('id');
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Logo(),
                          Stack(
                              alignment: Alignment.bottomRight,
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  foregroundImage: (file != null)
                                      ? FileImage(file)
                                      : NetworkImage(
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                                          as ImageProvider,
                                ),
                                Positioned(
                                  bottom: -10,
                                  right: -10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF6FAFA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        file = await pickImage();
                                        print(file);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              enabled: false,
                              minLines: 1,
                              maxLength: 100,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5),
                                hintText: '${widget.fullName}',
                                hintStyle: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: DateTimePicker(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Dont leave this empty";
                                }
                                return null;
                              },
                              initialDate: DateTime(2003),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              dateLabelText: 'Date of Birth',
                              onChanged: (value) {
                                dob = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              enabled: false,
                              minLines: 1,
                              maxLength: 100,
                              maxLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: ((newValue) {}),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5),
                                hintText: '${widget.email}',
                                hintStyle: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final code = await countryPicker
                                            .showPicker(context: context);
                                        if (code != null)
                                          setState(() {
                                            countrycode = code;
                                          });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Text(
                                            (countrycode != null)
                                                ? countrycode!.dialCode
                                                : '+91',
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 21),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: ((value) {
                                        if (value!.length != 10) {
                                          return 'Enter Valid Phone Number';
                                        }
                                        return null;
                                      }),
                                      minLines: 1,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      maxLines: 1,
                                      onChanged: ((newValue) {
                                        phone = newValue;
                                      }),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(5),
                                        hintText: "Phone Number",
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: DropDown(
                              items: ["Male", "Female", "Other"],
                              hint: Text("Male"),
                              icon: Icon(
                                Icons.expand_more,
                                color: Colors.blue,
                              ),
                              onChanged: (p0) {
                                gender = p0;
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF01C5A6)),
                                  onPressed: (() {
                                    if (dob!.length > 0 &&
                                        phone!.length > 9 &&
                                        gender != null) {
                                      print(widget.email);
                                      print(gender);
                                      print(phone);
                                      print(dob);
                                      print(widget.fullName);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OnBoardinginterest(
                                                    pfc: file,
                                                    edu: widget.edu,
                                                    email: widget.email,
                                                    gender: gender,
                                                    phone: (countrycode != null)
                                                        ? countrycode!
                                                                .dialCode +
                                                            phone!
                                                        : '+91' + phone!,
                                                    dob: dob,
                                                    fullName: widget.fullName,
                                                    userName: widget.userName)),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please Enter All Fields')));
                                    }
                                  }),
                                  child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          'Continue',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ),
                              )),
                        ]),
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
          future: SharedPreferences.getInstance()),
    );
  }

  Future<File?> pickImage() async {
    final _imagePicker = ImagePicker();
    XFile? image;
    image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
