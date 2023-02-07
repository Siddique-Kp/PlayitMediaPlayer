import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playit/screens/video/playing_video_screen/bottom_controller.dart';
import 'package:playit/screens/video/playing_video_screen/video_player_widget.dart';
import 'package:playit/screens/video/playing_video_screen/video_slider_controll.dart';
import 'package:video_player/video_player.dart';

class PlayingVideo extends StatefulWidget {
  final String videoFile;
  final String videoTitle;
  const PlayingVideo({
    super.key,
    required this.videoFile,
    required this.videoTitle,
  });

  @override
  State<PlayingVideo> createState() => _PlayingVideoState();
}

class _PlayingVideoState extends State<PlayingVideo> {
  late VideoPlayerController _controller;
  Duration videoDuration = const Duration();
  Duration videoPosition = const Duration();
  bool isPlaying = true;
  bool isVisible =true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile));
    _controller.initialize().then((_) => setState(() {}));
    _controller.setLooping(true);
    _controller.play();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    videoDuration = _controller.value.duration;
    videoPosition = _controller.value.position;
    final isMuted = _controller.value.volume == 0;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => setState(() {
          checkVisible();
         
        }),
        child: SafeArea(
          child: Stack(
            children: [
              VideoPlayerWidget(controller: _controller),
              Visibility(
                visible: isVisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      //----------- Appbar starts
                      child: AppBar(
                        backgroundColor: const Color.fromARGB(34, 0, 0, 0),
                        title: Text(
                          widget.videoTitle,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        leading: IconButton(
                            onPressed: () async {
                              await SystemChrome.setPreferredOrientations(
                                DeviceOrientation.values,
                              );

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(118, 0, 0, 0),
                        radius: 20,
                        child: IconButton(
                          onPressed: () {
                            _controller.setVolume(isMuted ? 1 : 0);
                          },
                          icon: Icon(isMuted
                              ? Icons.volume_off_outlined
                              : Icons.volume_up_outlined),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        VideoSliderController(
                          controller: _controller,
                          videoDuration: videoDuration,
                          videoPosition: videoPosition,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: VideoBottomController(
                            controller: _controller,
                            videoDuration: videoDuration,
                            videoPosition: videoPosition,
                            
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  checkVisible() {
    isVisible = false;
    Future.delayed(const Duration(seconds: 6), () => isVisible = true);
  }
}
