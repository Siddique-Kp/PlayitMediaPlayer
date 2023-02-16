import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/main.dart';
import '../../../model/playit_media_model.dart';
import '../playing_video_screen/playing_video.dart';
import '../video_bottom_sheet/video_bottom_sheet.dart';
import '../video_thumbnail.dart';

class VideoListBuilder extends StatefulWidget {
  const VideoListBuilder({
    super.key,
    required this.videoPath,
    required this.videoTitle,
    required this.duration,
    this.playlist,
    required this.index,
    this.isFavorite = false,
    this.isPlaylist = false,
    this.isFoldervideo = false,
    this.isSearchVideo = false,
  });
  final String videoPath;
  final String videoTitle;
  final String duration;
  final dynamic playlist;
  final int index;
  final bool isFavorite;
  final bool isPlaylist;
  final bool isFoldervideo;
  final bool isSearchVideo;

  @override
  State<VideoListBuilder> createState() => _VideoListBuilderState();
}

class _VideoListBuilderState extends State<VideoListBuilder> {
  String _duration = '00:00';
  @override
  void initState() {
    getduration();
    super.initState();
  }

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
        duration: _duration,
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
        duration: _duration,
        playList: widget.playlist,
        index: widget.index,
        isFavor: widget.isFavorite,
        isPlaylist: widget.isPlaylist,
      
      ),
    );
  }

  getduration() async {
    videoDB = await Hive.openBox<AllVideos>('videoplayer');
    List<AllVideos> data = videoDB.values.toList();
    List<AllVideos> result =
        data.where((element) => element.path == widget.videoPath).toList();
    if (result.isNotEmpty) {
      _duration = result
          .where((element) => element.path == widget.videoPath)
          .first
          .duration;
      setState(() {});
    }
  }
}
