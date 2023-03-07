import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:playit/database/recent_song_db.dart';
import 'package:provider/provider.dart';
import '../../../../provider/playing_song/playing_list_tile.dart';
import '../../songbottom_sheet/song_bottom_sheet.dart';
import '../../widgets/art_work.dart';

class SongListBuilder extends StatefulWidget {
  const SongListBuilder(
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

  @override
  State<SongListBuilder> createState() => _SongListBuilderState();
}

bool isPlayingSong = false;
double bodyBottomMargin = 0;
int selectedIndex = -1; // initially no item is selected

class _SongListBuilderState extends State<SongListBuilder> {
  final List<SongModel> allSongs = [];

  @override
  Widget build(BuildContext context) {
    final PlayingListTile playingTile = context.read<PlayingListTile>();

    return ListView.builder(
      shrinkWrap: widget.isPlaylist ? true : false,
      physics: const ScrollPhysics(),
      itemExtent: 80,
      itemBuilder: (context, index) {
        allSongs.addAll(widget.songModel);

        String songTitle = widget.songModel[index].displayNameWOExt;
        String artist = widget.songModel[index].artist!;
        String artistName = artist == "<unknown>" ? "Unknown artist" : artist;
        int playingSongId = widget.songModel[index].id;

        return Consumer<GetRecentSongController>(
            builder: (context, recentSong, child) {
          return ListTile(
            leading: ArtWorkWidget(
              songModel: widget.songModel[index],
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
              songModel: widget.songModel,
              songFavorite: widget.songModel[index],
              count: widget.songModel.length,
              index: index,
              isFavor: widget.isFavor,
              isPLaylist: widget.isPlaylist,
              playList: widget.playList,
            ),
            onTap: () {
              // setState(() {
              //   // selectedIndex = playingSongId; // update the selected index
              //   isPlayingSong = true;
              //   bodyBottomMargin = 50;
              // });
              // Provider.of<PlayingListTile>(context, listen: false)
              playingTile.selectedMusicTile(
                playingSongid: playingSongId,
                isPlaying: true,
                bodyBottomMargin: bodyBottomMargin,
              );
              selectedIndex = playingTile.isSelectedListTile;
              isPlayingSong = playingTile.isPlaying;
              bodyBottomMargin = playingTile.bodyBottomMargin;

              GetAllSongController.audioPlayer.setAudioSource(
                  GetAllSongController.createSongList(widget.songModel),
                  initialIndex: index);
              recentSong.addRecentlyPlayed(widget.songModel[index].id);
              GetAllSongController.audioPlayer.play();
              // Navigator.of(context).push(animatedRoute());
            },
            selected: selectedIndex == playingSongId,
            selectedColor:
                selectedIndex == playingSongId ? Colors.deepOrange : null,
          );
        });
      },
      itemCount:
          widget.isRecentSong ? widget.recentLength : widget.songModel.length,
    );
  }
}
