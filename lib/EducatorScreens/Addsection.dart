import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/EducatorScreens/hostedCourse.dart';

import 'package:skilledge/services/api_services.dart';

class AddSection extends StatefulWidget {
  const AddSection(
      {super.key,
      this.id,
      this.thumbnail,
      this.topic,
      this.desc,
      this.catog,
      this.price});
  final thumbnail;
  final id;
  final topic;
  final desc;
  final catog;
  final price;
  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> {
  File? file;

  String lessonname = "";

  bool loading = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          child: _pagebuild(context), inAsyncCall: loading, blur: 0.5),
    );
  }

  Widget _pagebuild(BuildContext context) {
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
        padding: const EdgeInsets.all(24.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              width: double.infinity,
              child: Center(
                  child: Text(
                'Create a Lesson',
                style: TextStyle(color: Color(0xFF01C5A6), fontSize: 24),
              ))),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                lessonname = value;
              },
              validator: (value) {
                if (value!.length == 0) {
                  return 'Enter Lesson Name';
                }
                return null;
              },
              decoration: InputDecoration(
                  label: Text('Lesson Name'), border: OutlineInputBorder()),
            ),
          ),
          TextButton(
              onPressed: () async {
                file = await pickVideo();
                setState(() {});
              },
              child: Text('Add Course')),
          Center(child: Text((file != null) ? file!.path : '')),
        ]),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          print(file);
          print(lessonname);
          if (file == null || lessonname.length <= 0) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please Vaidate All Entered Fields')));
          } else {
            setState(() {
              loading = true;
            });
            API api = API();
            api
                .hostCourse(
              widget.thumbnail,
              widget.desc,
              widget.price,
              widget.topic,
              lessonname,
              file!,
              widget.catog,
            )
                .then((value) {
              setState(() {
                loading = false;
              });
              print(value.toString());
              if (value.toString() == "{msg: lesson added}") {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => HostedCourse())));
              }
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
              color: Color(0xFF01C5A6),
              width: double.infinity,
              height: 46,
              child: Center(
                  child: Text(
                'Create Course',
                style: TextStyle(color: Colors.white),
              ))),
        ),
      ),
    );
  }

  Future<File?> pickVideo() async {
    final _imagePicker = ImagePicker();
    XFile? video;
    video = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      return File(video.path);
    }
    return null;
  }
}
