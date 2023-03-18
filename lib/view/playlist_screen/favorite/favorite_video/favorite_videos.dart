import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:playit/controller/database/video_favorite_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/view/playlist_screen/favorite/favorite_popup/favorite_popup.dart';
import 'package:playit/controller/videos/access_video_controller.dart';
import 'package:playit/view/videos/video/view/video_list_builder.dart';
import 'package:playit/controller/videos/video_thumbnail_controller.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class FavoriteVideos extends StatelessWidget {
  FavoriteVideos({super.key});

  final videoInfo = FlutterVideoInfo();

  @override
  Widget build(BuildContext context) {
    if (!VideoFavoriteDb.isInitialized) {
      for (int i = 0; i < accessVideosPath.length; i++) {
        Provider.of<VideoFavoriteDb>(context,listen: false).initialize(
          VideoFavoriteModel(
            title: accessVideosPath[i].toString().split('/').last,
            videoPath: accessVideosPath[i],
            videoSize: fileSize(accessVideosPath[i]),
          ),
        );
      }
    }

    return Consumer<VideoFavoriteDb>(
      builder: (context, value, child){
        final temp = VideoFavoriteDb.videoFavoriteDb.reversed.toList();
        final videoFavData = temp.toSet().toList();
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.black,
            title: const Text("Liked Videos"),
            actions: const [
              FavoritePopUp(
                isVideo: true,
              )
            ],
          ),
          body: videoFavData.isEmpty
              ? const Center(
                  child: Text(
                    "No Favorite Videos",
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 64, 64),
                      fontSize: 17,
                    ),
                  ),
                )
              : ListView.builder(
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
                ),
        );
      },
    );
  }
}
