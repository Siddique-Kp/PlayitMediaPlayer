import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({
    super.key,
    required this.controller,
    required this.fit,
    required this.index,
  });
  final VideoPlayerController controller;
  final dynamic fit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? buildVideo()
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildVideo() => Center(child: buildVideoPlayer());

  Widget buildVideoPlayer() => SizedBox.expand(
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          fit: fit[index],
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),
      );
}
