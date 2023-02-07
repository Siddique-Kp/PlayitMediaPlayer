import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSliderController extends StatefulWidget {
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
  State<VideoSliderController> createState() => _VideoSliderControllerState();
}

class _VideoSliderControllerState extends State<VideoSliderController> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.orange,
        thumbColor: Colors.orange,
        trackHeight: 2,
        inactiveTrackColor: Colors.white,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
      ),
      child: Slider(
        min: const Duration(microseconds: 0).inSeconds.toDouble(),
        max: widget.videoDuration.inSeconds.toDouble(),
        value: widget.videoPosition.inSeconds.toDouble(),
        onChanged: (value) {
          setState(() {
            changeSliderValue(value.toInt());
            value = value;
          });
        },
      ),
    );
  }

  void changeSliderValue(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.controller.seekTo(duration);
  }
}
