import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:playit/screens/music/playing_music/playing_music.dart';
import 'package:playit/database/recent_song_db.dart';
import 'package:playit/screens/music/songbottom_sheet/song_bottom_sheet.dart';
import 'package:playit/screens/playlist_screen/song_playlist_list/add_songs_playlist.dart';
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
              appBar: AppBar(
                title: Text(widget.playList.name),
                actions: [
                  IconButton(
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddSongsPlaylist(playlist: widget.playList),
                            ));
                      }),
                      icon: const Icon(Icons.playlist_add))
                ],
              ),
              body: songPlaylist.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'No Songs found',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return AddSongsPlaylist(
                                      playlist: widget.playList);
                                },
                              ));
                            },
                            label: const Text('Add songs'),
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: songPlaylist.length,
                      itemBuilder: (context, index) {
                        String artistName = songPlaylist[index].artist!;
                        String songTitle = songPlaylist[index].title;
                        return ListTile(
                          leading: QueryArtworkWidget(
                            id: songPlaylist[index].id,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(3),
                            artworkHeight: 60,
                            artworkWidth: 60,
                            artworkFit: BoxFit.cover,
                            nullArtworkWidget: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(3)),
                              width: 60,
                              height: 60,
                              child: const Center(
                                  child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          title: Text(
                            songTitle,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            artistName == '<unknown>'
                                ? "Unknown artist"
                                : artistName,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          trailing: SongBottomSheet(
                            songTitle: songTitle,
                            artistName: artistName,
                            songModel: songPlaylist,
                            songFavorite: songPlaylist[index],
                            count: songPlaylist.length,
                            index: index,
                            isPLaylist: true,
                            playList: widget.playList,
                          ),
                          onTap: () {
                            List<SongModel> musicPlaylist = [...songPlaylist];
                            GetAllSongController.audioPlayer.stop();
                            GetAllSongController.audioPlayer.setAudioSource(
                                GetAllSongController.createSongList(
                                    musicPlaylist),
                                initialIndex: index);
                            GetRecentSongController.addRecentlyPlayed(
                                musicPlaylist[index].id);
                            GetAllSongController.audioPlayer.play();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PlayingMusic(songModel: songPlaylist),
                                ));
                          },
                        );
                      },
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
