import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:playit/database/recent_song_db.dart';
import '../../playing_music/playing_music.dart';
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

class _SongListBuilderState extends State<SongListBuilder> {
  final List<SongModel> allSongs = [];
  int _selectedIndex = -1; // initially no item is selected

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: widget.isPlaylist ? true : false,
      physics: const ScrollPhysics(),
      itemExtent: 80,
      itemBuilder: (context, index) {
        allSongs.addAll(widget.songModel);

        String songTitle = widget.songModel[index].displayNameWOExt;
        String artist = widget.songModel[index].artist!;
        String artistName = artist == "<unknown>" ? "Unknown artist" : artist;

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
            setState(() {
              _selectedIndex = index; // update the selected index
              isPlayingSong = true;
            });

            GetAllSongController.audioPlayer.setAudioSource(
                GetAllSongController.createSongList(widget.songModel),
                initialIndex: index);
            GetRecentSongController.addRecentlyPlayed(
                widget.songModel[index].id);
            GetAllSongController.audioPlayer.play();
            // Navigator.of(context).push(animatedRoute());

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PlayingMusic(
            //       songModel: songModel,
            //       count: songModel.length,
            //     ),
            //   ),
            // );
          },
          selected: _selectedIndex == index,
          selectedColor: _selectedIndex == index ?  Colors.deepOrange: null,
        );
      },
      itemCount:
          widget.isRecentSong ? widget.recentLength : widget.songModel.length,
    );
  }

  Route animatedRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayingMusic(
        songModel: widget.songModel,
        count: widget.songModel.length,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
