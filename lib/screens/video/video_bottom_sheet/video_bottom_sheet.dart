import 'package:flutter/material.dart';
import 'package:playit/database/video_favorite_db.dart';
import 'package:playit/database/video_playlist_db.dart';
import 'package:playit/screens/video/playing_video_screen/playing_video.dart';
import 'package:playit/screens/video/video_bottom_sheet/video_addto_playlist.dart';
import 'package:playit/screens/video/video_bottom_sheet/video_details.dart';
import '../../../model/playit_media_model.dart';
import '../video_thumbnail.dart';

class VideoBottomSheet extends StatefulWidget {
  const VideoBottomSheet({
    super.key,
    required this.videoTitle,
    required this.videoPath,
    required this.videoSize,
    required this.duration,
    required this.index,
    this.isPlaylist = false,
    this.isFavor = false,
  });
  final String videoTitle;
  final String videoPath;
  final String videoSize;
  final String duration;
  final int index;
  final bool isPlaylist;
  final bool isFavor;

  @override
  State<VideoBottomSheet> createState() => _VideoBottomSheetState();
}

class _VideoBottomSheetState extends State<VideoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        videoBottomSheet(
            videoTitle: widget.videoTitle,
            videoPath: widget.videoPath,
            videoSize: widget.videoSize,
            duration: widget.duration,
            index: widget.index,
            isPlaylist: widget.isPlaylist,
            isFavor: widget.isFavor);
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
      required isFavor}) {
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
          return StatefulBuilder(builder: (context, setState) {
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
                    const Divider(
                      thickness: 1,
                    ),
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
                    !VideoFavoriteDb.isVideoFavor(
                      VideoFavoriteModel(
                          title: videoTitle,
                          videoPath: videoPath,
                          videoSize: fileSize(videoPath)),
                    )
                        ? ListTile(
                            leading: bottomIcon(Icons.favorite_border_outlined),
                            title: bottomText("Add to favorite"),
                            onTap: () {
                              setState(
                                () {
                                  VideoFavoriteDb.videoAdd(
                                      VideoFavoriteModel(
                                        title: videoTitle,
                                        videoPath: videoPath,
                                        videoSize: fileSize(videoPath),
                                      ),
                                      context);
                                  VideoFavoriteDb.videoFavoriteDb
                                      .notifyListeners();
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
                            title: bottomText("Remove from favorite"),
                            onTap: () {
                              setState(
                                () {
                                  VideoFavoriteDb.videoDelete(
                                      videoPath, context);
                                  VideoFavoriteDb.videoFavoriteDb
                                      .notifyListeners();
                                },
                              );
                              if (isFavor) {
                                Navigator.pop(context);
                              }
                            },
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
                          showdialog(index);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            );
          });
        });
  }



  bottomStyle() {
    return TextButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 21, 21, 21),
    );
  }

  showdialog(
    int index,
  ) {
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
                  )),
              onTap: () {
                Navigator.pop(context);
                VideoPlaylistDb.deleteListItem(index: index, context: context);
                VideoPlaylistDb.playlistitemsNotifier.notifyListeners();
                snackBar(
                    inTotal: 4,
                    width: 3,
                    context: context,
                    content: "Deleted successfully",
                    bgcolor: Colors.black54);
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
