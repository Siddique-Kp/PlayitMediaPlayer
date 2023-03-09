import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/player.dart';
import '../../../../../controller/database/video_favorite_db.dart';
import '../../../../playlist_screen/floating_button.dart/controller/playlist_dialogue.dart';

class VideoAddToPlayList extends StatelessWidget {
  const VideoAddToPlayList({
    super.key,
    required this.videoPath,
    required this.duration,
  });
  final String videoPath;
  final String duration;

  @override
  Widget build(BuildContext context) {
    final videoHivebox = Hive.box<PlayerModel>('PlayerDB');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to Playlist"),
      ),
      body: ValueListenableBuilder(
        valueListenable: videoHivebox.listenable(),
        builder: (context, Box<PlayerModel> videoList, child) {
          return videoHivebox.isEmpty
              ? const Center(
                  child: Text(
                    "No Playlist Found",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: videoList.length,
                  itemBuilder: (context, index) {
                    final data = videoList.values.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.video_collection_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(data.name),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          videoAddToPlaylist(
                            videoPath,
                            data,
                            data.name,
                            context,
                          );
                        },
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.playlist_add),
        onPressed: () {
          PlayListDialogue.newPlayList(
            context,
            "Playlist for Video",
            false,
          );
        },
      ),
    );
  }

  void videoAddToPlaylist(
    String data,
    PlayerModel playList,
    String name,
    context,
  ) {
    if (!playList.isValueIn(data)) {
      playList.add(data);
      snackBar(
        context: context,
        content: "Video added to $name",
        width: 3,
        inTotal: 4,
      );
    } else {
      snackBar(
        context: context,
        content: "Video already exist in $name",
        width: 3,
        inTotal: 4,
      );
    }
  }
}
