import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playit/view/music/controller/get_all_songs.dart';
import 'package:playit/view/videos/playing_video_screen/bottom_controller.dart';
import 'package:playit/view/videos/playing_video_screen/video_player_widget.dart';
import 'package:playit/view/videos/playing_video_screen/video_slider_controll.dart';
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

bool isVisible = true;
bool isLocked = false;

class _PlayingVideoState extends State<PlayingVideo> {
  late VideoPlayerController _controller;
  Duration videoDuration = const Duration();
  Duration videoPosition = const Duration();
 late int videoMicrDuration;
  Duration videoMicrPosition = const Duration();
  bool isPlaying = true;
  bool isLandscape = true;

  @override
  void initState() {
    GetAllSongController.audioPlayer.stop();
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile));
    _controller.initialize().then((_) => setState(() {}));
    // _controller.setLooping(true);
    _controller.play();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    disposeOrientation();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    videoDuration = _controller.value.duration;
    videoPosition = _controller.value.position;
    videoMicrDuration = _controller.value.duration.inMicroseconds;
    videoMicrPosition = _controller.value.position;
    final isMuted = _controller.value.volume == 0;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => setState(
          () {
            if (isLocked != true) checkVisible();
          },
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Visibility(
                visible: isLocked,
                child: Positioned(
                  left: 10,
                  top: 10,
                  child: ColoredBox(
                    color: const Color.fromARGB(125, 158, 158, 158),
                    child: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            isVisible = !isVisible;
                            isLocked = !isLocked;
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              VideoPlayerWidget(controller: _controller,fit: fit,index: fitIndex),
              Visibility(
                visible: isVisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      //----------- Appbar starts
                      child: AppBar(
                        backgroundColor:Colors.black.withAlpha(100),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(118, 0, 0, 0),
                            radius: 20,
                            child: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    setLandscape();
                                    isLandscape = !isLandscape;
                                  },
                                );
                              },
                              icon: const Icon(Icons.screen_rotation),
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
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
                        ],
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

  Future disposeOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
  }

  Future setLandscape() async {
    if (isLandscape) {
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }

  checkVisible() {
    isVisible = true;
    Future.delayed(const Duration(seconds: 5), () => isVisible = false);
  }
}
