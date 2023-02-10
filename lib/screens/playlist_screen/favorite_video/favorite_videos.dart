import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/video/access_video.dart';
import 'package:playit/screens/video/video_list/video_list_builder.dart';
import 'package:playit/screens/video/video_thumbnail.dart';
import '../../../main.dart';

class FavoriteVideos extends StatelessWidget {
  FavoriteVideos({super.key});

  final videoInfo = FlutterVideoInfo();

  @override
  Widget build(BuildContext context) {
    if (!VideoFavoriteDb.isInitialized) {
      for (int i = 0; i < accessVideosPath.length; i++) {
        VideoFavoriteDb.initialize(
          VideoFavoriteModel(
            title: accessVideosPath[i].toString().split('/').last,
            videoPath: accessVideosPath[i],
            videoSize: fileSize(accessVideosPath[i]),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        title: const Text("Favorite Videos"),
      ),
      body: ValueListenableBuilder(
          valueListenable: VideoFavoriteDb.videoFavoriteDb,
          builder: (context, List<VideoFavoriteModel> videoData, child) {
            final temp = videoData.reversed.toList();
            final videoFavData = temp.toSet().toList();

            if (videoFavData.isEmpty) {
              return const Center(
                child: Text("No Favorite Videos"),
              );
            }
            return ListView.builder(
              itemCount: videoFavData.length,
              itemBuilder: (context, index) {
                final videoListData = videoFavData[index];
                String videoPath = videoListData.videoPath;
                final videoTitle = videoPath.toString().split('/').last;
                String shorttitle = videoTitle;
                if (videoTitle.length > 19) {
                    shorttitle = shorttitle.substring(0, 19);
                  }
                AllVideos? videoinfo = videoDB.getAt(index);
                String duration =
                    videoinfo!.duration.toString().split('.').first;

                return VideoListBuilder(
                  videoPath: videoPath,
                  videoTitle: shorttitle,
                  duration: duration,
                  index: index,
                  isFavorite: true,
                );
              },
            );
          }),
    );
  }
}
