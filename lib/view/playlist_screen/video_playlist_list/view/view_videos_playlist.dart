import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playit/model/player.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/controller/videos/access_video_controller.dart';
import 'package:provider/provider.dart';
import '../../../../controller/videos/video_playlist_controller.dart';
import '../../../../main.dart';
import '../../../../controller/videos/video_thumbnail_controller.dart';

class AddVideosToPlayList extends StatelessWidget {
  const AddVideosToPlayList({super.key, required this.playlist});
  final PlayerModel playlist;

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

          return allVideos.value.isEmpty
              ? const Center(
                  child: Text('No videos'),
                )
              : ListView.builder(
                  itemCount: accessVideosPath.length,
                  itemExtent: 75,
                  itemBuilder: (context, index) {
                    String path = accessVideosPath[index];
                    final videoTitle =
                        accessVideosPath[index].toString().split('/').last;
                    String shorttitle = videoTitle;
                    if (videoTitle.length > 19) {
                      shorttitle = shorttitle.substring(0, 19);
                    }
                    AllVideos? videoinfo = videoDB.getAt(index);

                    return Consumer<VideoPlaylistController>(
                        builder: (context, videoPlaylistController, child) {
                      return ListTile(
                        leading: thumbnail(
                          path: path,
                          context: context,
                          duration:
                              videoinfo!.duration.toString().split(".").first,
                        ),
                        title: Text(
                          shorttitle,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                        subtitle: Text(fileSize(path)),
                        trailing: !playlist.isValueIn(path)
                            ? IconButton(
                                onPressed: () {
                                  videoPlaylistController.addVideosToPlaylist(
                                    videoModel: playlist,
                                    path: path,
                                    context: context,
                                  );
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
                                  videoPlaylistController
                                      .removeVideosFromPlaylist(
                                    videoModel: playlist,
                                    path: path,
                                  );
                                },
                                icon: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      );
                    });
                  },
                );
        },
      ),
    );
  }
}
