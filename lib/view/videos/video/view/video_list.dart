import 'package:flutter/material.dart';
import 'package:playit/main.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/view/videos/video/view/video_list_builder.dart';
import '../../../../controller/videos/access_video_controller.dart';

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
