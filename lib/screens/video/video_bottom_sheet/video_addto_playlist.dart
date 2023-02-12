import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/player.dart';
import '../../../database/video_favorite_db.dart';

class VideoAddToPlayList extends StatefulWidget {
  const VideoAddToPlayList({
    super.key,
    required this.videoPath,
    required this.duration,
  });
  final String videoPath;
  final String duration;

  @override
  State<VideoAddToPlayList> createState() => _VideoAddToPlayListState();
}

class _VideoAddToPlayListState extends State<VideoAddToPlayList> {
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
            return ListView.builder(
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
                          videoAddToPlaylist(widget.videoPath, data, data.name);
                        }),
                  );
                });
          }),
    );
  }

  void videoAddToPlaylist(String data, PlayerModel playList, String name) {
    if (!playList.isValueIn(data)) {
      playList.add(data);
      snackBar(
        context: context,
        content: "Video added to $name",
        width: 2,
        inTotal: 4,
        bgcolor: const Color.fromARGB(255, 44, 43, 43),
      );
    } else {
      snackBar(
        context: context,
        content: "Video already exist in $name",
        width: 3,
        inTotal: 4,
        bgcolor: const Color.fromARGB(255, 44, 43, 43),
      );
    }
  }
}
