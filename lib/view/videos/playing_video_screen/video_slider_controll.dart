import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../controller/videos/playing_video_controller.dart';

class VideoSliderController extends StatelessWidget {
  final VideoPlayerController controller;
  final Duration videoDuration;
  final Duration videoPosition;
  const VideoSliderController({
    super.key,
    required this.controller,
    required this.videoDuration,
    required this.videoPosition,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.blue,
        thumbColor: Colors.blue,
        trackHeight: 2,
        inactiveTrackColor: Colors.white,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
      ),
      child: Consumer<PlayingVideoController>(
          builder: (context, playingVideoController, child) {
        return Slider(
          min: const Duration(microseconds: 0).inSeconds.toDouble(),
          max: videoDuration.inSeconds.toDouble(),
          value: videoPosition.inSeconds.toDouble(),
          onChanged: (value) {
            playingVideoController.changeSlider(value, controller);
          },
        );
      }),
    );
  }
}
