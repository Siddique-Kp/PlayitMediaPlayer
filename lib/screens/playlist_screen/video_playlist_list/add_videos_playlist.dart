import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/database/video_playlist_db.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/video/access_video.dart';
import 'package:playit/screens/video/video_thumbnail.dart';
import '../../../main.dart';
import '../../video/video_bottom_sheet/video_addto_playlist.dart';

class AddVideosToPlayList extends StatefulWidget {
  const AddVideosToPlayList(
      {super.key, required this.playlist, required this.playlistFolderIndex});
  final dynamic playlist;
  final int? playlistFolderIndex;

  @override
  State<AddVideosToPlayList> createState() => _AddVideosToPlayListState();
}

class _AddVideosToPlayListState extends State<AddVideosToPlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Videos To Playlist")),
        body: FutureBuilder(
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
                  String path = accessVideosPath[index];
                  final videoTitle =
                      accessVideosPath[index].toString().split('/').last;
                  AllVideos? videoinfo = videoDB.getAt(index);
                  final listitemshive =
                      Hive.box<VideoPlayListItem>('VideoListItemsBox');
                  List<VideoPlayListItem> playlist =
                      listitemshive.values.toList();
                  List<VideoPlayListItem> result = playlist
                      .where((element) =>
                          element.videoPath == path &&
                          element.playlistFolderindex ==
                              widget.playlistFolderIndex)
                      .toList();

                  return ListTile(
                      leading: thumbnail(
                        path: path,
                        context: context,
                        duration:
                            videoinfo!.duration.toString().split(".").first,
                      ),
                      title: Text(
                        videoTitle,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      subtitle: Text(fileSize(path)),
                      trailing: result.isEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  addItemToPlayList(
                                      playlistFolderIndex:
                                          widget.playlistFolderIndex,
                                      videoPath: path,
                                      context: context,
                                      duration: videoinfo.duration);
                                });
                              },
                              icon: const CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 10,
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                ),
                              ))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  VideoPlaylistDb.deleteListItem(
                                      index: index, context: context);
                                  VideoPlaylistDb.playlistitemsNotifier
                                      .notifyListeners();
                                });
                              },
                              icon: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.horizontal_rule,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              )));
                },
              );
            }));
  }
}
