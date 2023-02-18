import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:playit/database/recent_song_db.dart';
import '../../playing_music/playing_music.dart';
import '../../songbottom_sheet/song_bottom_sheet.dart';

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

        final String songTitle = songModel[index].displayNameWOExt;
        // String songTitle = songfullTitle;
        //           if (songTitle.length > 20) {
        //             songTitle = '${songTitle.substring(0, 20)}...';
        //           }
        String artist = songModel[index].artist!;
        String artistName = artist == "<unknown>" ? "Unknown artist" : artist;

        return ListTile(
          leading: QueryArtworkWidget(
            id: songModel[index].id,
            type: ArtworkType.AUDIO,
            keepOldArtwork: true,
            artworkBorder: BorderRadius.circular(3),
            artworkHeight: 60,
            artworkWidth: 60,
            artworkFit: BoxFit.cover,
            nullArtworkWidget: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(3)),
              width: 60,
              height: 60,
              child: const Center(
                  child: Icon(
                Icons.music_note,
                color: Colors.white,
              )),
            ),
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
            count: songModel.length,
            index: index,
            isFavor: isFavor,
            isPLaylist: isPlaylist,
            playList: playList,
          ),
          onTap: () {
            GetAllSongController.audioPlayer.setAudioSource(
                GetAllSongController.createSongList(songModel),
                initialIndex: index);
            GetRecentSongController.addRecentlyPlayed(songModel[index].id);
            Navigator.of(context).push(animatedRoute());

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
        );
      },
      itemCount: isRecentSong ? recentLength : songModel.length,
    );
  }

  Route animatedRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayingMusic(
        songModel: songModel,
        count: songModel.length,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween),
        child: child,);
      },
    );
  }
}
