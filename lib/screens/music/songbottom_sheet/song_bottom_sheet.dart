import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/database/recent_song_db.dart';
import 'package:playit/screens/music/songbottom_sheet/add_to_favorite.dart';
import 'package:playit/screens/music/songbottom_sheet/add_to_playlist.dart';
import 'package:playit/screens/music/songbottom_sheet/delete_list.dart';
import 'package:playit/screens/music/songbottom_sheet/details_song.dart';
import 'package:playit/screens/music/songbottom_sheet/widgets/icons.dart';
import 'package:playit/screens/music/songbottom_sheet/widgets/text.dart';
import 'package:provider/provider.dart';
import '../../../provider/music_buttons/music_buttond_provider.dart';
import '../get_all_songs.dart';

class SongBottomSheet extends StatelessWidget {
  const SongBottomSheet({
    super.key,
    required this.songTitle,
    required this.artistName,
    required this.songModel,
    required this.songFavorite,
    required this.index,
    this.isPLaylist = false,
    this.playList,
    this.isFavor = false,
  });
  final String songTitle;
  final String? artistName;
  final List<SongModel> songModel;
  final SongModel songFavorite;
  final int index;
  final bool isPLaylist;
  final dynamic playList;
  final bool isFavor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          songBottomSheet(
              context: context,
              songTitle: songTitle,
              artistName: artistName,
              songModel: songModel,
              songFavorite: songFavorite,
              index: index,
              isPlayList: isPLaylist,
              playList: playList,
              isFavor: isFavor);
        },
        icon: const Icon(Icons.more_vert));
  }

  void songBottomSheet(
      {required context,
      required songTitle,
      required artistName,
      required List<SongModel> songModel,
      required SongModel songFavorite,
      required index,
      required isPlayList,
      required playList,
      required isFavor}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        songTitle,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Consumer2<GetRecentSongController, MusicButtonsProvider>(
                  builder: (context, recentSong, selectedItem, child) {
                    return ListTile(
                      leading: const Icon(
                        Icons.play_arrow_rounded,
                        size: 37,
                        color: Color.fromARGB(255, 21, 21, 21),
                      ),
                      title: bottomText("Play"),
                      onTap: () {
                        recentSong.addRecentlyPlayed(songModel[index].id);
                        GetAllSongController.audioPlayer.setAudioSource(
                            GetAllSongController.createSongList(songModel),
                            initialIndex: index);
                        GetAllSongController.audioPlayer.play();
                        Navigator.of(context).pop();
                        selectedItem.selectedListTile(songModel[index].id);
                      },
                    );
                  },
                ),
                AddToFavorite(
                  songFavorite: songFavorite,
                  isFavor: isFavor,
                ),
                ListTile(
                  leading: bottomIcon(Icons.playlist_add),
                  title: bottomText("Add To Playlist"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToPlaylist(
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
                SongDetails(
                  artistName: artistName,
                  songModel: songFavorite,
                ),
                SongDelete(
                  isPlaylist: isPLaylist,
                  playList: playList,
                  songModel: songModel[index],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
