import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/view/music/controller/get_all_songs.dart';
import 'package:playit/controller/database/recent_song_db.dart';
import 'package:provider/provider.dart';
import '../../../../../controller/music/music_tile_controller.dart';
import '../../songbottom_sheet/view/song_bottom_sheet.dart';
import '../../../widgets/art_work.dart';

class SongListBuilder extends StatelessWidget {
  SongListBuilder(
      {super.key,
      required this.songModel,
      this.isRecentSong = false,
      this.recentLength = 0,
      this.isFavor = false,
      this.isPlaylist = false,
      this.playList});
  final List<SongModel> songModel;
  final bool isRecentSong;
  final int recentLength;
  final bool isFavor;
  final bool isPlaylist;
  final dynamic playList;

  final List<SongModel> allSongs = [];

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: isPlaylist ? true : false,
      physics: const ScrollPhysics(),
      itemExtent: 80,
      itemBuilder: (context, index) {
        allSongs.addAll(songModel);

        String songTitle = songModel[index].displayNameWOExt;
        String artist = songModel[index].artist!;
        String artistName = artist == "<unknown>" ? "Unknown artist" : artist;
        int playingSongId = songModel[index].id;
        int selectedIndex = context.watch<MusicTileController>().selectedIndex;

        return Consumer2<GetRecentSongController,MusicTileController>(
          builder: (context, recentSong,playingTile, child) {
            return ListTile(
              leading: ArtWorkWidget(
                songModel: songModel[index],
                size: 60,
              ),
              title: SizedBox(
                width: MediaQuery.of(context).size.width * 3 / 5,
                child: Text(
                  songTitle,
                  maxLines: 1,
                ),
              ),
              subtitle: Text(
                artistName,
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
              trailing: SongBottomSheet(
                songTitle: songTitle,
                artistName: artistName,
                songModel: songModel,
                songFavorite: songModel[index],
                index: index,
                isFavor: isFavor,
                isPLaylist: isPlaylist,
                playList: playList,
              ),
              onTap: () {
                playingTile.selectedMusicTile(
                  playingSongid: playingSongId,
                );

                GetAllSongController.audioPlayer.setAudioSource(
                    GetAllSongController.createSongList(songModel),
                    initialIndex: index);
                recentSong.addRecentlyPlayed(songModel[index].id);
                GetAllSongController.audioPlayer.play();
              },
              selected: selectedIndex == playingSongId,
              selectedColor:
                  selectedIndex == playingSongId ? Colors.deepOrange : null,
            );
          },
        );
      },
      itemCount: isRecentSong ? recentLength : songModel.length,
    );
  }
}
