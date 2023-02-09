import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/get_all_songs.dart';
import 'package:playit/database/recent_song_db.dart';
import '../../playing_music/playing_music.dart';
import '../../songbottom_sheet/song_bottom_sheet.dart';

class SongListBuilder extends StatefulWidget {
  const SongListBuilder({
    super.key,
    required this.songModel,
    this.isRecentSong = false,
    this.recentLength = 0,
    this.isFavor = false,
    this.isPlaylist = false,
    this.playList
  });
  final List<SongModel> songModel;
  final bool isRecentSong;
  final int recentLength;
  final bool isFavor;
  final bool isPlaylist;
  final dynamic playList;

  @override
  State<SongListBuilder> createState() => _SongListBuilderState();
}

class _SongListBuilderState extends State<SongListBuilder> {
  List<SongModel> allSongs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: widget.isPlaylist ? true : false,
      physics: const ScrollPhysics(),
      itemExtent: 80,
      itemBuilder: (context, index) {
        allSongs.addAll(widget.songModel);

        final String songTitle = widget.songModel[index].displayNameWOExt;
        String artist =widget.songModel[index].artist!;
        String artistName = artist == "<unknown>" ? "Unknown artist":artist;

        return ListTile(
          leading: QueryArtworkWidget(
            id: widget.songModel[index].id,
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
          title: Text(
            songTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
            GetAllSongController.audioPlayer.setAudioSource(
                GetAllSongController.createSongList(widget.songModel),
                initialIndex: index);
            GetRecentSongController.addRecentlyPlayed(
                widget.songModel[index].id);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayingMusic(
                  songModel: widget.songModel,
                  count: widget.songModel.length,
                ),
              ),
            );
          },
        );
      },
      itemCount:
          widget.isRecentSong ? widget.recentLength : widget.songModel.length,
    );
  }
}
