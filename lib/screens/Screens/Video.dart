import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_controls/video_controls.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, this.file});
  final file;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoController.network(widget.file);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(_controller),
            ],
          ),
        ),
      ),
    );
  }
}
