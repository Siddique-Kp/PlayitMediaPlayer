import 'package:flutter/material.dart';
import 'package:playit/controller/music/now_playing_provider.dart';
import 'package:provider/provider.dart';

class MusicSliderWidget extends StatelessWidget {
  const MusicSliderWidget({
    super.key,
    required this.duration,
    required this.position,
  });
  final Duration position;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2 / 5),
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
          value: position.inSeconds.toDouble(),
          max: duration.inSeconds.toDouble(),
          onChanged: (value) {
            context.read<NowPlayingProvider>().changeSlider(value);
          },
        ),
      ),
    );
  }
}
