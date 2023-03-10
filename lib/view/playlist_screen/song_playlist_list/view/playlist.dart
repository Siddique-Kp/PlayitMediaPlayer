import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playit/view/playlist_screen/song_playlist_list/view/play_list_popup.dart';
import 'package:playit/view/playlist_screen/song_playlist_list/view/song_list.dart';
import '../../../../model/playit_media_model.dart';

class NewMusicPlaylist extends StatelessWidget {
  const NewMusicPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    final musicHivebox = Hive.box<PlayItSongModel>('songplaylistDb');

    return ValueListenableBuilder(
      valueListenable: musicHivebox.listenable(),
      builder: (context, Box<PlayItSongModel> musicList, child) {
        return musicHivebox.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 10,
                child: const Center(
                  child: Text(
                    "No Song Playlist",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  final data = musicList.values.toList()[index];
                  final itemCount = data.songId.length;
                  String songCount =
                      itemCount < 2 ? "$itemCount Song" : '$itemCount Songs';
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.library_music,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(data.name),
                    subtitle: Text(songCount),
                    trailing: PlayListPopUpMusic(
                      playlist: data,
                      musicPlayitList: musicList,
                      index: index,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SongPlayListList(
                            playList: data,
                            listIndex: index,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
