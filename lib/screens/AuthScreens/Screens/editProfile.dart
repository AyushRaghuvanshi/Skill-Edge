import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilledge/models/profile_details_model.dart';

import '../../../services/api_services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {super.key,
      this.pic,
      this.name,
      this.dob,
      this.phone,
      this.user_name,
      this.gender,
      this.is_educator});
  final pic;
  final name;
  final dob;
  final phone;
  final user_name;
  final gender;
  final is_educator;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var file;

  String? dob;
  late Profile_details_req req;
  final countryPicker = const FlCountryCodePicker();

  String? phone;

  CountryCode? countrycode;

  late TextEditingController _name = TextEditingController(text: widget.name);

  late TextEditingController _dob = TextEditingController(text: widget.dob);

  late TextEditingController _phone =
      TextEditingController(text: widget.phone.toString());

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    req = Profile_details_req();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            ' My Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                        alignment: Alignment.bottomRight,
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            foregroundImage: (file != null)
                                ? FileImage(file)
                                : NetworkImage((widget.pic != null)
                                        ? widget.pic!
                                        : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                                    as ImageProvider,
                          ),
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6FAFA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: IconButton(
                                color: Colors.black,
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  print('he');
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
                        controller: _name,
                        minLines: 1,
                        maxLength: 100,
                        // initialValue: widget.name,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: DateTimePicker(
                        // validator: (value) {
                        //   if (value!.length == 0) {
                        //     return "Dont leave this empty";
                        //   }
                        // },
                        controller: _dob,
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
                                  final code = await countryPicker.showPicker(
                                      context: context);
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
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 21),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: ((value) {
                                  if (value!.length != 10) {
                                    return 'Enter Valid Phone Number';
                                  }
                                }),
                                minLines: 1,
                                // controller: _phone,
                                initialValue:
                                    widget.phone.toString().substring(2),
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                maxLines: 1,
                                onChanged: ((newValue) {
                                  phone = newValue;
                                }),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: "Phone Number",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.only(bottom: 20.0),
                    //   child: DropDown(
                    //     items: ["Male", "Female", "Other"],
                    //     hint: Text("Male"),
                    //     icon: Icon(
                    //       Icons.expand_more,
                    //       color: Colors.blue,
                    //     ),
                    //     onChanged: (p0) {
                    //       gender = p0;
                    //     },
                    //   ),
                    // ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1D1E21)),
                            onPressed: (() {
                              setState(() {
                                loading = true;
                              });
                              API api = API();
                              req.name = _name.text;
                              req.dateOfBirth = widget.dob;

                              req.mobile = _phone.text;
                              req.picture = file;
                                  
                              req.gender = widget.gender;
                              req.isEducator = widget.is_educator;
                              req.userName = widget.user_name;
                              print(req.toJson());
                              api.profile(req).then((value) {
                                if (value.message != null) {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value.message!)));
                                }
                              });
                            })

                            // print(widget.email);
                            // print(gender);
                            // print(phone);
                            // print(dob);
                            // print(widget.fullName);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => OnBoardinginterest(
                            //           pfc: file,
                            //           edu: widget.edu,
                            //           email: widget.email,
                            //           gender: gender,
                            //           phone: (countrycode != null)
                            //               ? countrycode!.dialCode + phone!
                            //               : '+91' + phone!,
                            //           dob: dob,
                            //           fullName: widget.fullName,
                            //           userName: widget.userName)),
                            // );
                            ,
                            child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    'Save',
                                  ),
                                )),
                          ),
                        )),
                  ]),
            ),
          ),
        ));
  }

  Future<File?> pickImage() async {
    final _imagePicker = ImagePicker();
    XFile? image;
    image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
  }
}
