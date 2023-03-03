import 'package:flutter/material.dart';
import 'package:playit/screens/music/music_page/songs/song_list_builder.dart';
import 'package:playit/screens/music/widgets/art_work.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../get_all_songs.dart';
import '../../playing_music/playing_music.dart';
import '../../widgets/favorite_song_button.dart';
import '../../widgets/next_song_button.dart';
import '../../widgets/play_song_button.dart';

class NowPlayingBottomSheet extends StatefulWidget {
  const NowPlayingBottomSheet({
    super.key,
  });

  @override
  State<NowPlayingBottomSheet> createState() => _NowPlayingBottomSheetState();
}

bool firstSong = false;

bool isPlaying = false;

class _NowPlayingBottomSheetState extends State<NowPlayingBottomSheet> {
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          index == 0 ? firstSong = true : firstSong = false;
        });
      }
    });
    GetAllSongController.audioPlayer.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isPlayingSong) {
      final songModel = GetAllSongController.playingSong;
      final songModelEach = GetAllSongController
          .playingSong[GetAllSongController.audioPlayer.currentIndex!];
      String artistName = songModelEach.artist.toString() == "<unknown>"
          ? "Unknown Artist"
          : songModelEach.artist.toString();
      String songName = songModelEach.displayNameWOExt;
      return BottomSheet(
          enableDrag: false,
          onDragStart: (details) {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => PlayingMusic(
            //         songModel: songModel,
            //         count: songModel.length,
            //       ),
            //     ),
            //   );
          },
          onClosing: () {},
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayingMusic(
                      songModel: songModel,
                      count: songModel.length,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.black.withAlpha(50),
                height: 60,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 9,
                      ),
                      child: ArtWorkWidget(
                        songModel: songModelEach,
                        size: 45,
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StreamBuilder<bool>(
                                stream: GetAllSongController
                                    .audioPlayer.playingStream,
                                builder: (context, snapshot) {
                                  bool? playingStage = snapshot.data;
                                  if (playingStage != null && playingStage) {
                                    return TextScroll(
                                      songModelEach.displayNameWOExt,
                                      textAlign: TextAlign.center,
                                      velocity: const Velocity(
                                        pixelsPerSecond: Offset(40, 0),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    );
                                  } else {
                                    return Text(
                                      songName,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    );
                                  }
                                },
                              ),
                              TextScroll(
                                artistName,
                                velocity: const Velocity(
                                  pixelsPerSecond: Offset(35, 0),
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blueGrey,
                                ),
                                mode: TextScrollMode.endless,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // IconButton(
                        //   onPressed: () {
                        //     setState(
                        //       () {
                        //         isPlayingSong = false;
                        //       },
                        //     );
                        //   },
                        //   icon: const Icon(Icons.close),
                        // ),
// ----- Favorite button
                        FavoriteButton(
                          songFavorite: songModelEach,
                        ),
// --------- Play and pause button
                        SongPauseButton(
                          songModel: songModelEach,
                          iconPlay: const Icon(
                            Icons.play_circle,
                            color: Colors.white,
                            size: 35,
                          ),
                          iconPause: const Icon(
                            Icons.pause_circle,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
// ----------- Skip to next song button
                        SongSkipNextButton(
                          favSongModel: songModelEach,
                          iconSize: 30,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      return const SizedBox();
    }
  }
}
