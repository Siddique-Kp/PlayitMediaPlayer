import 'package:flutter/material.dart';
import 'package:playit/view/music/widgets/art_work.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../core/boolians.dart';
import '../../../../controller/music/get_all_songs_controller.dart';
import '../../widgets/favorite_song_button.dart';
import '../../widgets/next_song_button.dart';
import '../../widgets/play_song_button.dart';
import 'routes/animated_route.dart';

class MiniPlayerSheet extends StatefulWidget {
  const MiniPlayerSheet({
    super.key,
  });

  @override
  State<MiniPlayerSheet> createState() => _MiniPlayerSheetState();
}

class _MiniPlayerSheetState extends State<MiniPlayerSheet> {
  // @override
  // void initState() {
  //   setState(() {});
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    if (isPlayingSong) {
      final songModel = GetAllSongController.playingSong;
      final singleSongModel = GetAllSongController
          .playingSong[GetAllSongController.audioPlayer.currentIndex!];
      String artistName = singleSongModel.artist.toString() == "<unknown>"
          ? "Unknown Artist"
          : singleSongModel.artist.toString();
      String songName = singleSongModel.displayNameWOExt;
      return BottomSheet(
        enableDrag: false,
        onDragStart: (details) {},
        onClosing: () {},
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                animatedRoute(songModel),
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
                      songModel: singleSongModel,
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
                                    songName,
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
                      FavoriteButton(
                        songFavorite: singleSongModel,
                      ), 
// --------- Play and pause button
                      SongPauseButton(
                        songModel: singleSongModel,
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
                        songModel: singleSongModel,
                        iconSize: 30,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
