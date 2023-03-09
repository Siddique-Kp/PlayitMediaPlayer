import 'package:flutter/material.dart';
import 'package:playit/model/database/video_favorite_db.dart';
import 'package:playit/model/player.dart';
import 'package:playit/view/videos/playing_video_screen/playing_video.dart';
import 'package:playit/view/videos/video/view/video_bottom_sheet/video_addfavorite.dart';
import 'package:playit/view/videos/video/view/video_bottom_sheet/video_addto_playlist.dart';
import 'package:playit/view/videos/video/view/video_bottom_sheet/video_details.dart';

class VideoBottomSheet extends StatelessWidget {
  const VideoBottomSheet({
    super.key,
    required this.videoTitle,
    required this.videoPath,
    required this.videoSize,
    required this.duration,
    this.playList,
    required this.index,
    this.isPlaylist = false,
    this.isFavor = false,
  });
  final String videoTitle;
  final String videoPath;
  final String videoSize;
  final String duration;
  final dynamic playList;
  final int index;
  final bool isPlaylist;
  final bool isFavor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        videoBottomSheet(
            videoTitle: videoTitle,
            videoPath: videoPath,
            videoSize: videoSize,
            duration: duration,
            index: index,
            isPlaylist: isPlaylist,
            isFavor: isFavor,
            context: context);
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  void videoBottomSheet(
      {required videoTitle,
      required videoPath,
      required videoSize,
      required duration,
      required index,
      required isPlaylist,
      required isFavor,
      required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          videoTitle,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Divider(thickness: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.play_arrow_rounded,
                        size: 37,
                        color: Color.fromARGB(255, 21, 21, 21),
                      ),
                      title: bottomText("Play"),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayingVideo(
                              videoFile: videoPath,
                              videoTitle: videoTitle,
                            ),
                          ),
                        );
                      },
                    ),
                    VideoAddToFavorite(
                      videoPath: videoPath,
                      videoTitle: videoTitle,
                      videoSize: videoSize,
                      isFavor: isFavor,
                    ),
                    ListTile(
                      leading: bottomIcon(Icons.playlist_add),
                      title: bottomText("Add to playlist"),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoAddToPlayList(
                              videoPath: videoPath,
                              duration: duration,
                            ),
                          ),
                        );
                      },
                    ),
                    VideoDetailsePage(
                      videoPath: videoPath,
                      duration: duration,
                    ),
                    Visibility(
                      visible: isPlaylist,
                      child: ListTile(
                        leading: bottomIcon(Icons.delete),
                        title: bottomText('Delete'),
                        onTap: () {
                          Navigator.pop(context);
                          showdialog(playList, videoPath, index, context);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  bottomStyle() {
    return TextButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 21, 21, 21),
    );
  }

  showdialog(
      PlayerModel playList, String videoPath, int index, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: [
            InkWell(
              child: const SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    "Remove from playlist",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                playList.deleteData(videoPath);
                snackBar(
                  inTotal: 5,
                  width: 3,
                  context: context,
                  content: "Deleted successfully",
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            InkWell(
              child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

Widget bottomText(text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget bottomIcon(icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Icon(
      icon,
      size: 27,
      color: const Color.fromARGB(255, 21, 21, 21),
    ),
  );
}
