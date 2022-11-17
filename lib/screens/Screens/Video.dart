import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    super.initState();
    _controller = VideoController.network(widget.file);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(164, 0, 0, 0),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(
                    _controller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
