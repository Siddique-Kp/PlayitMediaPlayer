import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../core/boolians.dart';
import '../../../controller/get_all_songs.dart';
import '../../../widgets/favorite_song_button.dart';
import '../../../widgets/next_song_button.dart';
import '../../../widgets/play_song_button.dart';
import '../../../widgets/previous_song_button.dart';

class MusicBottomButtons extends StatelessWidget {
   const MusicBottomButtons({
    super.key,
    required this.songModel,
    required this.firstsong,
    required this.lastsong,
    required this.count,
  });
  final int count;
  final bool firstsong;
  final bool lastsong;
  final SongModel songModel;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                isShuffling == false
                    ? GetAllSongController.audioPlayer
                        .setShuffleModeEnabled(true)
                    : GetAllSongController.audioPlayer
                        .setShuffleModeEnabled(false);
              },
              icon: StreamBuilder<bool>(
                stream:
                    GetAllSongController.audioPlayer.shuffleModeEnabledStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    isShuffling = snapshot.data;
                  }
                  if (isShuffling) {
                    return const Icon(Icons.shuffle_rounded,
                        color: Colors.deepOrange);
                  } else {
                    return const Icon(Icons.shuffle_rounded,
                        color: Colors.white);
                  }
                },
              ),
            ),
            FavoriteButton(songFavorite: songModel),
            IconButton(
              onPressed: () {
                GetAllSongController.audioPlayer.loopMode == LoopMode.one
                    ? GetAllSongController.audioPlayer.setLoopMode(LoopMode.all)
                    : GetAllSongController.audioPlayer
                        .setLoopMode(LoopMode.one);
              },
              icon: StreamBuilder<LoopMode>(
                stream: GetAllSongController.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopMode = snapshot.data;
                  if (LoopMode.one == loopMode) {
                    return const Icon(Icons.repeat_one,
                        color: Colors.deepOrange);
                  } else {
                    return const Icon(
                      Icons.repeat,
                      color: Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            firstsong
                ? const IconButton(
                    iconSize: 40,
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_previous,
                      color: Color.fromARGB(255, 122, 122, 122),
                    ),
                  )
                : SongSkipPreviousButton(
                    songModel: songModel,
                  ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: SongPauseButton(
                songModel: songModel,
                iconPause: const Icon(
                  Icons.pause,
                  color: Colors.black,
                  size: 35,
                ),
                iconPlay: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            lastsong
                ? const IconButton(
                    iconSize: 40,
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_next,
                      color: Color.fromARGB(255, 122, 122, 122),
                    ),
                  )
                : SongSkipNextButton(
                    songModel: songModel,
                    iconSize: 40,
                  ),
          ],
        ),
      ],
    );
  }
}


