import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../controller/videos/playing_video_controller.dart';

class VideoBottomController extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(videoPosition),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              _formatDuration(videoDuration),
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
                  Provider.of<PlayingVideoController>(context, listen: false)
                      .videoLockButtonController();
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
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              },
              icon: controller.value.isPlaying
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
                  Provider.of<PlayingVideoController>(context,listen: false)
                      .changeScreenView();
                },
                icon: icon(Icons.fit_screen)),
          ],
        )
      ],
    );
  }

  forwardSec(sec) {
    controller
        .seekTo(controller.value.position + Duration(seconds: sec));
  }

  rewindSec(sec) {
    controller
        .seekTo(controller.value.position - Duration(seconds: sec));
  }

  String _formatDuration(Duration duration) {
    String formattedDuration = duration.inHours > 0
        ? '${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}'
        : '${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';

    return formattedDuration;
  }

  Widget icon(videoIcon) {
    return Icon(
      videoIcon,
      color: Colors.white,
    );
  }
}
