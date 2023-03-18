import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playit/controller/videos/playing_video_controller.dart';
import 'package:playit/view/music/controller/get_all_songs.dart';
import 'package:playit/view/videos/playing_video_screen/bottom_controller.dart';
import 'package:playit/view/videos/playing_video_screen/video_player_widget.dart';
import 'package:playit/view/videos/playing_video_screen/video_slider_controll.dart';
import 'package:provider/provider.dart';
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
  late int videoMicrDuration;
  Duration videoMicrPosition = const Duration();

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
    bool isLocked = Provider.of<PlayingVideoController>(context).isLocked;
    bool isVisible =
        Provider.of<PlayingVideoController>(context).isVisibleScreen;
    final playingVideoController = context.watch<PlayingVideoController>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          if (isLocked != true) {
            Provider.of<PlayingVideoController>(context, listen: false)
                .checkVisible();
          }
        },
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
                        Provider.of<PlayingVideoController>(context,
                                listen: false)
                            .videoLockButtonController();
                      },
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              VideoPlayerWidget(
                controller: _controller,
                fit: playingVideoController.screenViews,
                index: playingVideoController.fitInsex,
              ),
              Visibility(
                visible: isVisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      //----------- Appbar starts
                      child: AppBar(
                        backgroundColor: Colors.black.withAlpha(100),
                        title: Text(
                          widget.videoTitle,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        leading: IconButton(
                            onPressed: () {
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
                                context
                                    .read<PlayingVideoController>()
                                    .landScapeMode();
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
}
