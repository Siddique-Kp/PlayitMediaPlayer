import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/song_favorite_db.dart';
import 'package:playit/screens/music/playing_music/playing_music.dart';
import 'package:playit/database/recent_song_db.dart';
import 'package:playit/screens/music/songbottom_sheet/song_bottom_sheet.dart';
import '../../music/get_all_songs.dart';

class FavoriteSongs extends StatefulWidget {
  const FavoriteSongs({super.key});

  @override
  State<FavoriteSongs> createState() => _FavoriteSongsState();
}

class _FavoriteSongsState extends State<FavoriteSongs> {
  List<SongModel> favoriteData = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder: (context, List<SongModel> favoriteSongData, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.black,
              title: const Text("Favorite Songs"),
            ),
            body: ValueListenableBuilder(
                valueListenable: FavoriteDb.favoriteSongs,
                builder: (context, List<SongModel> favoriteSongData, child) {
                  final temp = favoriteSongData.reversed.toList();
                  favoriteData = temp.toSet().toList();

                  if (favoriteData.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Favorite Songs",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: favoriteData.length,
                      itemBuilder: (context, index) {
                        String artistName = favoriteData[index].artist!;
                        String songTitle = favoriteData[index].displayNameWOExt;
                        return ListTile(
                          leading: QueryArtworkWidget(
                            id: favoriteData[index].id,
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
                            songModel: favoriteData,
                            songFavorite: favoriteData[index],
                            count: favoriteData.length,
                            index: index,
                          ),

                          // IconButton(
                          //     onPressed: () {
                          //       FavoriteDb.favoriteSongs.notifyListeners();
                          //       FavoriteDb.delete(favoriteData[index].id);
                          //       const snackbar = SnackBar(
                          //         content: Text('Song removed from favorites'),
                          //         duration: Duration(seconds: 1),
                          //       );
                          //       ScaffoldMessenger.of(context)
                          //           .showSnackBar(snackbar);
                          //     },
                          //     icon: const Icon(
                          //       Icons.favorite,
                          //       color: Colors.redAccent,
                          //     )),
                          onTap: () {
                            List<SongModel> favoriteList = [...favoriteData];
                            GetAllSongController.audioPlayer.stop();
                            GetAllSongController.audioPlayer.setAudioSource(
                                GetAllSongController.createSongList(
                                    favoriteList),
                                initialIndex: index);
                            GetRecentSongController.addRecentlyPlayed(
                                favoriteList[index].id);
                            GetAllSongController.audioPlayer.play();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PlayingMusic(songModel: favoriteList),
                                ));
                          },
                        );
                      },
                    );
                  }
                }),
          );
        });
  }
}
