import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilledge/EducatorScreens/Addsection.dart';
import 'package:skilledge/EducatorScreens/Dashboard.dart';
import 'package:skilledge/EducatorScreens/home.dart';

class HostCoursePage extends StatefulWidget {
  const HostCoursePage({super.key});

  @override
  State<HostCoursePage> createState() => _HostCoursePageState();
}

class _HostCoursePageState extends State<HostCoursePage> {
  File? file;

  String topic = "";

  int? catog;

  String price = "0";

  String desc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Host',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                file = await pickImage();

                setState(() {});
              },
              child: DottedBorder(
                dashPattern: [10, 10],
                strokeWidth: 2,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (file != null)
                              ? FileImage(file!)
                              : NetworkImage(
                                      'https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png')
                                  as ImageProvider)),
                  width: double.infinity,
                  height: 128,
                  child: Center(child: Text('Add Thumbnail')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  topic = value;
                },
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Enter a topic';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text('Topic'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  desc = value;
                },
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Enter a Description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text('Description'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: double.infinity,
                height: 46,
                child: DropDown(
                    onChanged: ((p0) {
                      switch (p0) {
                        case 'Developement':
                          catog = 1;
                          break;
                        case 'Business':
                          catog = 2;
                          break;
                        case 'Finance & Accounting':
                          catog = 3;
                          break;
                        case 'IT & Software':
                          catog = 4;
                          break;
                        case 'Office Productivity':
                          catog = 5;
                          break;
                        case 'Personal Development':
                          catog = 6;
                          break;
                        case 'Design':
                          catog = 7;
                          break;
                        case 'Marketing':
                          catog = 8;
                          break;
                        case 'Health & Fitness':
                          catog = 9;
                          break;
                        case 'Music':
                          catog = 10;
                          break;
                        case 'Teaching & Academics':
                          catog = 11;
                          break;
                      }
                    }),
                    hint: Text('Choose Categories'),
                    items: [
                      'Developement',
                      'Business',
                      'Finance & Accounting',
                      'IT & Software',
                      'Office Productivity',
                      'Personal Development',
                      'Design ',
                      'Marketing ',
                      'Health & Fitness',
                      'Music ',
                      'Teaching & Academics'
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: TextFormField(
                enabled: iscertified,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  price = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text((iscertified!) ? 'Price' : "Free"),
                    border: OutlineInputBorder()),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Color(0xFF01C5A6)),
          child: Container(
              width: double.infinity,
              height: 46,
              child: Center(
                  child: Text(
                'Host Your Course',
                style: TextStyle(color: Colors.white),
              ))),
          onPressed: () {
            if (file == null ||
                topic.length <= 0 ||
                catog == null ||
                price.length <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please Vaidate All Entered Fields')));
            } else
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => AddSection(
                            topic: topic,
                            catog: catog,
                            desc: desc,
                            price: price,
                            thumbnail: file,
                          ))));
          },
        ),
      ),
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
