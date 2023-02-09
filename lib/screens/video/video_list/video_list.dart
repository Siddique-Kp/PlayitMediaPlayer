import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/video/playing_video_screen/playing_video.dart';
import 'package:playit/screens/video/video_bottom_sheet/video_bottom_sheet.dart';
import 'package:playit/screens/video/video_thumbnail.dart';
import 'package:video_player/video_player.dart';
import '../../../main.dart';
import '../access_video.dart';

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
        
          return ListView.builder(
            itemCount: accessVideosPath.length,
            itemExtent: 75,
            itemBuilder: (context, index) {
              final path = accessVideosPath[index];
              final videoTitle =
                  accessVideosPath[index].toString().split('/').last;
              AllVideos? videoinfo = videoDB.getAt(index);

              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayingVideo(
                        videoFile: path,
                        videoTitle: videoTitle,
                      ),
                    ),
                  );
                },
                leading: thumbnail(
                  path: path,
                  context: context,
                  duration: videoinfo!.duration.toString().split(".").first,
                ),
                title: Text(
                  videoTitle,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                subtitle: Text(fileSize(path)),
                trailing: VideoBottomSheet(
                  videoTitle: videoTitle,
                  videoPath: path,
                  videoSize: fileSize(path),
                  duration:videoinfo.duration.toString().split(".").first,
                  index: index,
                ),
              );
            },
          );
        });
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
