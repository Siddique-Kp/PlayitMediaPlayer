import 'package:flutter/material.dart';
import 'package:playit/database/video_playlist_db.dart';
import 'package:playit/main.dart';
import 'package:playit/screens/video/video_list/video_list_builder.dart';
import '../../../model/playit_media_model.dart';
import 'add_videos_playlist.dart';

class VideoPlayListList extends StatefulWidget {
  const VideoPlayListList({
    super.key,
    required this.playList,
    required this.listIndex,
  });
  final VideoPlaylistModel playList;
  final int listIndex;

  @override
  State<VideoPlayListList> createState() => _VideoPlayListListState();
}

class _VideoPlayListListState extends State<VideoPlayListList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playList.name),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddVideosToPlayList(
                          playlist: widget.playList,
                          playlistFolderIndex: widget.playList.index),
                    ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: VideoPlaylistDb.playlistitemsNotifier,
        builder: (
          context,
          List<VideoPlayListItem> videoPlaylistItems,
          child,
        ) {
          if (videoPlaylistItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No videos here.",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddVideosToPlayList(
                            playlist: widget.playList,
                            playlistFolderIndex: widget.playList.index),
                      ),
                    ),
                    child: const Text("ADD VIDEOS"),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: videoPlaylistItems.length,
              itemBuilder: (context, index) {
                final data = videoPlaylistItems[index];
                String videoPath = data.videoPath;
                String videoTitle = videoPath.split('/').last;
                String shorttitle = videoTitle;
                if (videoTitle.length > 19) {
                  shorttitle = shorttitle.substring(0, 19);
                }
                AllVideos? info = videoDB.getAt(index);
                String duration = info!.duration.split('.').first;

                if (widget.playList.index == data.playlistFolderindex) {
                  return VideoListBuilder(
                    videoPath: videoPath,
                    videoTitle: shorttitle,
                    duration: duration,
                    index: index,
                    isPlaylist: true,
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          }
        },
      ),
    );
  }
}
