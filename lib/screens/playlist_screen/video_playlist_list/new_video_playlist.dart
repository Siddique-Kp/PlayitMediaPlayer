import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/model/playit_media_model.dart';
import 'package:playit/screens/playlist_screen/video_playlist_list/video_playlist_list.dart';
import 'package:playit/screens/playlist_screen/video_playlist_list/video_popup_menu.dart';

class NewVideoPlaylist extends StatelessWidget {
  const NewVideoPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    final videoHivebox = Hive.box<VideoPlaylistModel>('VideoPlaylistDb');
    return ValueListenableBuilder(
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
                    // subtitle: const Text('5 Songs'),
                    trailing: PlayListPopUpVideo(
                      playlist: data,
                      videoPlayitList: videoList,
                      index: index,
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return   VideoPlayListList(
                          playList: data,
                          listIndex: index,
                          
                        );
                      },
                    )),
                  ),
                );
              });
        });
  }
}
