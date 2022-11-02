import 'dart:io';

import 'package:country_phone_code_picker/core/country_phone_code_picker_widget.dart';
import 'package:country_phone_code_picker/models/country.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingQA extends StatefulWidget {
  const OnboardingQA({super.key, this.fullName, this.email});
  final fullName;
  final email;
  @override
  State<OnboardingQA> createState() => _OnboardingQAState();
}

class _OnboardingQAState extends State<OnboardingQA> {
  int? id;
  var file;
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
                              onChanged: ((newValue) {}),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5),
                                hintText: '${widget.fullName}',
                                hintStyle: const TextStyle(color: Colors.black),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: DateTimePicker(
                              initialValue: '',
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                              ),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              dateLabelText: 'Date of Birth',
                              onChanged: (val) => print(val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
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
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: CountryPhoneCodePicker
                                      .withDefaultSelectedCountry(
                                    defaultCountryCode: Country(
                                        name: 'India',
                                        countryCode: 'IN',
                                        phoneCode: '+91'),
                                    borderRadius: 5,
                                    borderWidth: 1,
                                    borderColor: Colors.grey,
                                    style: const TextStyle(fontSize: 16),
                                    searchBarHintText: 'Search by name',
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 18),
                                    child: TextFormField(
                                      minLines: 1,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      maxLines: 1,
                                      onChanged: ((newValue) {}),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(5),
                                        hintText: "Phone Number",
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextDropdownFormField(
                              options: ["Male", "Female", "Other"],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  labelText: "Gender"),
                              dropdownHeight: 80,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: ElevatedButton(
                                onPressed: (() {
                                
                                }),
                                child: Text('Continue'),
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
      var file = File(image.path);
      return file;
    }
  }
}
