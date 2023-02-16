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

int fitIndex = 0;
List<BoxFit> fit = [
  BoxFit.cover,
  BoxFit.fitHeight,
  BoxFit.contain,
];

class _VideoBottomControllerState extends State<VideoBottomController> {
  bool isPlaying = true;
  bool isLandscape = false;

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
                    fitIndex = (fitIndex + 1) % fit.length;
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

  Future lockScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
  }
}
