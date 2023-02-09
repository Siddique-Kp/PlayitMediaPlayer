import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';
import 'package:playit/screens/playlist_screen/song_playlist_list/add_songs_playlist.dart';
import 'package:playit/screens/playlist_screen/song_playlist_list/inside_playlist_popup.dart';
import '../../../model/playit_media_model.dart';

class SongPlayListList extends StatefulWidget {
  const SongPlayListList({
    super.key,
    required this.playList,
    required this.listIndex,
  });
  final PlayItSongModel playList;
  final int listIndex;

  @override
  State<SongPlayListList> createState() => _SongPlayListListState();
}

class _SongPlayListListState extends State<SongPlayListList> {
  @override
  Widget build(BuildContext context) {
    List<SongModel> songPlaylist;
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<PlayItSongModel>('songPlaylistDb').listenable(),
        builder: (context, Box<PlayItSongModel> musicList, child) {
          songPlaylist =
              listPlaylist(musicList.values.toList()[widget.listIndex].songId);
          return Scaffold(
              body: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.playList.name),
                  background: Image.asset(
                    "assets/Headset.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                actions: [
                  InsidePopupSong(
                    playlist: widget.playList,
                    index: widget.listIndex,
                  )
                ],
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * 3 / 10,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                songPlaylist.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No songs here.',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    elevation: MaterialStatePropertyAll(0)),
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddSongsPlaylist(
                                          playlist: widget.playList,
                                        ),
                                      ),
                                    ),
                                child: const Text("ADD SONGS"))
                          ],
                        ),
                      )
                    : SongListBuilder(
                        songModel: songPlaylist,
                        playList: widget.playList,
                        isPlaylist: true,
                      ),
              ]))
            ],
          ));
        });
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetAllSongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongController.songscopy[i].id == data[j]) {
          plsongs.add(GetAllSongController.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
