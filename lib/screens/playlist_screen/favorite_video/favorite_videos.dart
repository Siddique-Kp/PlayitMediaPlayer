import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/video/access_video.dart';
import 'package:playit/screens/video/playing_video_screen/playing_video.dart';
import 'package:playit/screens/video/video_thumbnail.dart';

import '../../../main.dart';
import '../../video/video_bottom_sheet/video_bottom_sheet.dart';

class FavoriteVideos extends StatefulWidget {
  const FavoriteVideos({super.key});

  @override
  State<FavoriteVideos> createState() => _FavoriteVideosState();
}

class _FavoriteVideosState extends State<FavoriteVideos> {
  final videoInfo = FlutterVideoInfo();
  // final videoFavDb = VideoFavDb();
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
          builder: (context, List<VideoFavoriteModel> videoFavData, child) {
            if (videoFavData.isEmpty) {
              return const  Center(
                child: Text("No Favorite Videos"),
              );
            }
            return ListView.builder(
              itemCount: videoFavData.length,
              itemBuilder: (context, index) {
                final videoListData = videoFavData[index];
                final videoPath = videoListData.videoPath;
                final videoTitle = videoPath.toString().split('/').last;
                AllVideos? videoinfo = videoDB.getAt(index);
                return ListTile(
                  leading: thumbnail(
                    path: videoListData.videoPath,
                    context: context,
                    duration: videoinfo!.duration.split('.').first,
                  ),
                  title: Text(
                    videoTitle,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  subtitle: Text(fileSize(videoListData.videoPath)),
                  trailing: VideoBottomSheet(
                    videoTitle: videoTitle,
                    videoPath: videoPath,
                    videoSize: fileSize(videoListData.videoPath),
                    duration: videoinfo.duration.split('.').first,
                    index: index,
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayingVideo(
                            videoFile: videoPath, videoTitle: videoTitle),
                      )),
                );
              },
            );
          }),
    );
  }

  fileSize(path) {
    final fileSizeInBytes = File(path).lengthSync();
    if (fileSizeInBytes < 1024) {
      return '$fileSizeInBytes bytes';
    }
    if (fileSizeInBytes < 1048576) {
      return '${(fileSizeInBytes / 1024).toStringAsFixed(1)}KB';
    }
    if (fileSizeInBytes < 1073741824) {
      return '${(fileSizeInBytes / 1048576).toStringAsFixed(1)}MB';
    }
    return '${(fileSizeInBytes / 1073741824).toStringAsFixed(1)}GB';
  }
}
