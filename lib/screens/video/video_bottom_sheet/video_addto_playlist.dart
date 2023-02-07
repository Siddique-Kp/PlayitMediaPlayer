import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/database/video_playlist_db.dart';
import 'package:playit/model/playit_media_model.dart';
import '../../../database/video_favorite_db.dart';

class VideoAddToPlayList extends StatefulWidget {
  const VideoAddToPlayList({
    super.key,
    required this.videoPath,
    required this.duration,
  });
  final dynamic videoPath;
  final dynamic duration;

  @override
  State<VideoAddToPlayList> createState() => _VideoAddToPlayListState();
}

class _VideoAddToPlayListState extends State<VideoAddToPlayList> {
  @override
  Widget build(BuildContext context) {
    final videoHivebox = Hive.box<VideoPlaylistModel>('VideoPlaylistDb');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to Playlist"),
      ),
      body: ValueListenableBuilder(
          valueListenable: videoHivebox.listenable(),
          builder: (context, Box<VideoPlaylistModel> videoList, child) {
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
                        addItemToPlayList(
                          playlistFolderIndex: data.index,
                          videoPath: widget.videoPath,
                          context: context,
                          duration: widget.duration,
                        );
                      },
                    ),
                  );
                });
          }),
    );
  }
}

addItemToPlayList(
    {required playlistFolderIndex,
    required String videoPath,
    required context,
    required duration}) async {
  final list = VideoPlayListItem(
      playlistFolderindex: playlistFolderIndex,
      videoPath: videoPath,
      duration: duration);
  final listitemshive =
      await Hive.openBox<VideoPlayListItem>('VideoListItemsBox');
  List<VideoPlayListItem> playlist = listitemshive.values.toList();
  List<VideoPlayListItem> result = playlist
      .where((element) =>
          element.videoPath == videoPath &&
          element.playlistFolderindex == playlistFolderIndex)
      .toList();
  if (videoPath.isEmpty) {
    return;
  } else if (result.isNotEmpty) {
    snackBar(
      context: context,
      content: "Video already exist",
      width: 2,
      inTotal: 4,
      bgcolor: const Color.fromARGB(255, 67, 65, 65),
    );
  } else {
    VideoPlaylistDb.videoListItemadd(list);
    snackBar(
      context: context,
      content: 'Video added successfully',
      width: 3,
      inTotal: 5,
      bgcolor: const Color.fromARGB(255, 67, 65, 65),
    );
  }
}
