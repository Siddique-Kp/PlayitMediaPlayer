import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? buildVideo()
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildVideo() => Center(child: buildVideoPlayer());

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}
