import 'package:flutter/material.dart';
import 'package:playit/view/videos/video/video_bottom_sheet/video_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../controller/database/video_favorite_db.dart';
import '../../../../model/playit_media_model.dart';

class VideoAddToFavorite extends StatelessWidget {
  const VideoAddToFavorite({
    super.key,
    required this.videoPath,
    required this.videoTitle,
    required this.videoSize,
    this.isFavor = false,
  });
  final String videoTitle;
  final String videoPath;
  final String videoSize;
  final bool isFavor;

  @override
  Widget build(BuildContext context) {
    return Provider.of<VideoFavoriteDb>(context).isVideoFavor(
      VideoFavoriteModel(
          title: videoTitle,
          videoPath: videoPath,
          videoSize: videoSize),
    )
        ? ListTile(
            leading: bottomIcon(Icons.favorite_border_outlined),
            title: bottomText("Add To Favorite"),
            onTap: () {
              Provider.of<VideoFavoriteDb>(context, listen: false).videoAdd(
                  VideoFavoriteModel(
                    title: videoTitle,
                    videoPath: videoPath,
                    videoSize: videoSize,
                  ),
                  context);
            },
          )
        : ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: 27,
              ),
            ),
            title: bottomText("Added To Favorite"),
            onTap: () {
              Provider.of<VideoFavoriteDb>(context, listen: false)
                  .videoDelete(videoPath, context);

              if (isFavor) {
                Navigator.pop(context);
              }
            },
          );
  }
}
