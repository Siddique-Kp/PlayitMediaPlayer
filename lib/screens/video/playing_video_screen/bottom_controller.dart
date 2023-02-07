import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoBottomController extends StatefulWidget {
  final Duration videoPosition;
  final Duration videoDuration;
  final VideoPlayerController controller;
  final bool isLocked;

  const VideoBottomController(
      {super.key,
      required this.controller,
      required this.videoDuration,
      required this.videoPosition,
      this.isLocked = false});

  @override
  State<VideoBottomController> createState() => _VideoBottomControllerState();
}

class _VideoBottomControllerState extends State<VideoBottomController> {
  bool isPlaying = true;
  bool isLandscape = true;
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
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: icon(Icons.lock_open_rounded)),
            IconButton(
                iconSize: 40,
                onPressed: () {
                  rewindSec(10);
                },
                icon: icon(Icons.fast_rewind_rounded)),
            IconButton(
              onPressed: () {
                setState(() {
                  if (widget.controller.value.isPlaying) {
                    widget.controller.pause();
                  } else {
                    widget.controller.play();
                  }
                  isPlaying = !isPlaying;
                });
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
                    setLandscape();
                    isLandscape = !isLandscape;
                  });
                },
                icon: icon(Icons.crop_landscape_rounded)),
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

  Future setLandscape() async {
    if (isLandscape) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }
}
