import 'dart:io';

import 'package:tchauafasiaplayer/model/MediaModel.dart';
import 'package:tchauafasiaplayer/tool/MediaTool.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class PlayerUi extends StatefulWidget {
  final MediaModel media;

  PlayerUi({
    required this.media,
  });

  @override
  _PlayerUiState createState() => _PlayerUiState();
}

class _PlayerUiState extends State<PlayerUi> {
  late VideoPlayerController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    final mediaFile = File(MediaTool.videoPathOf(widget.media));
    _controller = VideoPlayerController.file(mediaFile);
    await _controller.initialize();
    // Ensure the first frame is shown after the video is initialized,
    // even before the play button has been pressed. (setState(() {});)
    setState(() {});
    _controller.play();
    _controller.setLooping(true);
  }

  _pop() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            if (widget.media.title != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                color: Colors.white,
                child: Text(
                  widget.media.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
