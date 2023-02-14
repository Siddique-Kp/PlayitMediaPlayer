import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playit/screens/video/playing_video_screen/playing_video.dart';
import 'package:video_player/video_player.dart';

class VideoBottomController extends StatefulWidget {
  final Duration videoPosition;
  final Duration videoDuration;
  final VideoPlayerController controller;

  const VideoBottomController({
    super.key,
    required this.controller,
    required this.videoDuration,
    required this.videoPosition,
  });

  @override
  State<VideoBottomController> createState() => _VideoBottomControllerState();
}

class _VideoBottomControllerState extends State<VideoBottomController> {
  bool isPlaying = true;
  bool isLandscape = false;
  int _index = 0;
  List<BoxFit> fit = [
    BoxFit.fitWidth,
    BoxFit.cover,
    BoxFit.fitHeight,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(widget.videoPosition),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              _formatDuration(widget.videoDuration),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(
                    () {
                      isVisible = false;
                      isLocked = true;
                      lockScreen();
                    },
                  );
                },
                icon: icon(Icons.lock_open_rounded)),
            IconButton(
                iconSize: 40,
                onPressed: () {
                  rewindSec(10);
                },
                icon: icon(Icons.fast_rewind_rounded)),
            IconButton(
              onPressed: () {
                setState(
                  () {
                    if (widget.controller.value.isPlaying) {
                      widget.controller.pause();
                    } else {
                      widget.controller.play();
                    }
                    isPlaying = !isPlaying;
                  },
                );
              },
              icon: widget.controller.value.isPlaying
                  ? icon(Icons.pause_rounded)
                  : icon(Icons.play_arrow_rounded),
              iconSize: 50,
            ),
            IconButton(
                iconSize: 40,
                onPressed: () {
                  forwardSec(10);
                },
                icon: icon(Icons.fast_forward)),
            IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    _index = (_index + 1) % fit.length;
                  });
                },
                icon: icon(Icons.fit_screen)),
          ],
        )
      ],
    );
  }

  forwardSec(sec) {
    widget.controller
        .seekTo(widget.controller.value.position + Duration(seconds: sec));
  }

  rewindSec(sec) {
    widget.controller
        .seekTo(widget.controller.value.position - Duration(seconds: sec));
  }

  String _formatDuration(Duration d) {
    int minute = d.inMinutes;
    int second = (d.inSeconds > 59) ? (d.inSeconds % 60) : d.inSeconds;
    String format =
        "${(minute < 10) ? "0$minute" : "$minute"}:${(second < 10) ? "0$second" : "$second"}";
    return format;
  }

  Widget icon(videoIcon) {
    return Icon(
      videoIcon,
      color: Colors.white,
    );
  }

  Future lockScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
  }

  // Future setLandscape() async {
  //   if (isLandscape) {
  //     // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     //     overlays: []);
  //     await SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.landscapeLeft,
  //       DeviceOrientation.landscapeRight,
  //     ]);
  //   } else {
  //     await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  //   }
  // }
}
