import 'package:flutter/material.dart';
import '../playing_video_screen/playing_video.dart';
import '../video_bottom_sheet/video_bottom_sheet.dart';
import '../video_thumbnail.dart';

class VideoListBuilder extends StatefulWidget {
  const VideoListBuilder({
    super.key,
    required this.videoPath,
    required this.videoTitle,
    required this.duration,
    required this.index,
    this.isFavorite = false,
    this.isPlaylist = false,
  });
  final String videoPath;
  final String videoTitle;
  final String duration;
  final int index;
  final bool isFavorite;
  final bool isPlaylist;

  @override
  State<VideoListBuilder> createState() => _VideoListBuilderState();
}

class _VideoListBuilderState extends State<VideoListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayingVideo(
              videoFile: widget.videoPath,
              videoTitle: widget.videoTitle,
            ),
          ),
        );
      },
      leading: thumbnail(
        path: widget.videoPath,
        context: context,
        duration: widget.duration,
      ),
      title: Text(
        widget.videoTitle,
        overflow: TextOverflow.clip,
        maxLines: 1,
      ),
      subtitle: Text(fileSize(widget.videoPath)),
      trailing: VideoBottomSheet(
        videoTitle: widget.videoTitle,
        videoPath: widget.videoPath,
        videoSize: fileSize(widget.videoPath),
        duration: widget.duration,
        index: widget.index,
        isFavor:widget.isFavorite ,
        isPlaylist: widget.isPlaylist,
      ),
    );
  }
}
