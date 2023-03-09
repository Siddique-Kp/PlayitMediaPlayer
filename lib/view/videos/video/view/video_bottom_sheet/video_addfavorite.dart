import 'package:flutter/material.dart';
import 'package:playit/view/videos/video/view/video_bottom_sheet/video_bottom_sheet.dart';

import '../../../../../controller/database/video_favorite_db.dart';
import '../../../../../model/playit_media_model.dart';

class VideoAddToFavorite extends StatefulWidget {
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
  State<VideoAddToFavorite> createState() => _VideoAddToFavoriteState();
}

class _VideoAddToFavoriteState extends State<VideoAddToFavorite> {
  @override
  Widget build(BuildContext context) {
    return !VideoFavoriteDb.isVideoFavor(
      VideoFavoriteModel(
          title: widget.videoTitle,
          videoPath: widget.videoPath,
          videoSize: widget.videoSize),
    )
        ? ListTile(
            leading: bottomIcon(Icons.favorite_border_outlined),
            title: bottomText("Add To Favorite"),
            onTap: () {
              setState(
                () {
                  VideoFavoriteDb.videoAdd(
                      VideoFavoriteModel(
                        title: widget.videoTitle,
                        videoPath: widget.videoPath,
                        videoSize: widget.videoSize,
                      ),
                      context);
                  VideoFavoriteDb.videoFavoriteDb.notifyListeners();
                },
              );
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
              setState(
                () {
                  VideoFavoriteDb.videoDelete(widget.videoPath, context);
                  VideoFavoriteDb.videoFavoriteDb.notifyListeners();
                },
              );
              if (widget.isFavor) {
                Navigator.pop(context);
              }
            },
          );
  }
}
