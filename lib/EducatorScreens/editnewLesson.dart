import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/services/api_services.dart';

class EditAddSection extends StatefulWidget {
  const EditAddSection(
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
  State<EditAddSection> createState() => _EditAddSectionState();
}

class _EditAddSectionState extends State<EditAddSection> {
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
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                    return 'Enter a topic';
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
                child: Text(
                  'Add Course',
                  style: TextStyle(color: Color(0xFF01C5A6)),
                )),
            Center(child: Text((file != null) ? file!.path : '')),
          ]),
        ),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          
          setState(() {
            loading = true;
          });
          API api = API();
          api.addLesson(widget.id, lessonname, file!).then((value) {
            setState(() {
              loading = false;
            });
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
              color: Color(0xFF01C5A6),
              width: double.infinity,
              height: 46,
              child: Center(
                  child: Text(
                'Add New Lesson',
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
