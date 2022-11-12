import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
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
                  return 'Enter a topic';
                }
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
      bottomNavigationBar: TextButton(
        onPressed: () {
          API api = API();
          api.addLesson(widget.id, lessonname, file!);
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
  }
}
