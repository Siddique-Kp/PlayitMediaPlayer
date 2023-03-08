import 'package:flutter/material.dart';
import '../get_all_songs.dart';

class MusicSliderWidget extends StatefulWidget {
  const MusicSliderWidget({
    super.key,
    required this.duration,
    required this.position,
  });
  final Duration position;
  final Duration duration;

  @override
  State<MusicSliderWidget> createState() => _MusicSliderWidgetState();
}

class _MusicSliderWidgetState extends State<MusicSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2/5),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          thumbColor: Colors.white,
          trackHeight: 4,
          
          inactiveTrackColor: Colors.grey,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
        ),
        child: Slider(
            min: const Duration(microseconds: 0).inSeconds.toDouble(),
            value: widget.position.inSeconds.toDouble(),
            max: widget.duration.inSeconds.toDouble(),
            onChanged: (value) {
              setState(() {
                changeSliderValue(value.toInt());
                value = value;
              });
            }),
      ),
    );
  }

  void changeSliderValue(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }
}
