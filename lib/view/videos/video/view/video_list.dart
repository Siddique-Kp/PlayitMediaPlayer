import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/main.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/view/videos/video/view/video_list_builder.dart';
import 'package:video_player/video_player.dart';
import '../controller/access_video.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late List<VideoPlayerController> controller;

  @override
  void initState() {
    askPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requestPermission(Permission.storage),
      builder: (context, items) {
        if (items.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return allVideos.value.isEmpty
            ? const Center(
                child: Text(
                  'No Videos',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            : ListView.builder(
                itemCount: allVideos.value.length,
                itemBuilder: (context, index) {
                  String videoPath = accessVideosPath[index];
                  String videoTitle = videoPath.split('/').last;
                  String shorttitle = videoTitle;
                  if (videoTitle.length > 19) {
                    shorttitle = shorttitle.substring(0, 19);
                  }
                  AllVideos? videosinfo = videoDB.getAt(index);
                  String duration = videosinfo!.duration.split('.').first;
                  return VideoListBuilder(
                    videoPath: videoPath,
                    videoTitle: shorttitle,
                    duration: duration,
                    index: index,
                  );
                },
              );
      },
    );
  }

  askPermission() async {
    if (await requestPermission(Permission.storage)) {
      const Center(
        child: CircularProgressIndicator(),
      );
      setState(() {});
    }
  }
}
