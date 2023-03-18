import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/main.dart';
import 'package:playit/model/player.dart';
import 'package:playit/view/playlist_screen/song_playlist_list/view/song_list_popup.dart';
import 'package:playit/controller/videos/access_video.dart';
import 'package:playit/view/videos/video/view/video_list_builder.dart';
import '../../../../model/playit_media_model.dart';
import 'view_videos_playlist.dart';

class VideoPlayListList extends StatelessWidget {
  const VideoPlayListList({
    super.key,
    required this.playList,
    required this.listIndex,
  });
  final PlayerModel playList;
  final int listIndex;

  @override
  Widget build(BuildContext context) {
    List<String> allListVideos;
    List<String> tempVideo = [];
    return ValueListenableBuilder(
      valueListenable: Hive.box<PlayerModel>('PlayerDB').listenable(),
      builder: (context, Box<PlayerModel> videoPlaylistItems, child) {
        tempVideo = videoPlaylist(
            videoPlaylistItems.values.toList()[listIndex].videoPath);
        final temp = tempVideo.reversed.toList();
        allListVideos = temp.toSet().toList();
        return Scaffold(
          appBar: AppBar(
            title: Text(playList.name),
            actions: [
              InsidePopupSong(
                videoPlalist: playList,
                index: listIndex,
                isVideo: true,
              )
            ],
          ),
          body: allListVideos.isEmpty
              ? Center(
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
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddVideosToPlayList(
                              playlist: playList,
                            ),
                          ),
                        ),
                        child: const Text("ADD VIDEOS"),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: allListVideos.length,
                  itemBuilder: (context, index) {
                    String videoPath = allListVideos[index];
                    String videoTitle = videoPath.split('/').last;
                    String shorttitle = videoTitle;
                    if (videoTitle.length > 19) {
                      shorttitle = shorttitle.substring(0, 19);
                    }
                    AllVideos? info = videoDB.getAt(index);
                    String duration = info!.duration.split('.').first;

                    return VideoListBuilder(
                      videoPath: videoPath,
                      videoTitle: shorttitle,
                      duration: duration,
                      playlist: playList,
                      index: index,
                      isPlaylist: true,
                    );
                  },
                ),
        );
      },
    );
  }

  List<String> videoPlaylist(List<String> data) {
    List<String> testVideos = [];
    for (int i = 0; i < accessVideosPath.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (accessVideosPath[i] == data[j]) {
          testVideos.add(accessVideosPath[i]);
        }
      }
    }
    return testVideos;
  }
}
