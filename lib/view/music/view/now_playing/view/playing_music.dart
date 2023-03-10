import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/controller/music/now_playing_controller.dart';
import 'package:playit/core/colors.dart';
import 'package:playit/view/music/view/now_playing/widgets/music_bottom_buttons.dart';
import 'package:playit/view/music/view/now_playing/widgets/music_slider.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayingMusic extends StatefulWidget {
  const PlayingMusic({
    super.key,
    required this.songModel,
    this.count = 0,
  });
  final List<SongModel> songModel;
  final int count;

  @override
  State<PlayingMusic> createState() => _PlayingMusicState();
}

class _PlayingMusicState extends State<PlayingMusic> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 47, 46, 46),
      statusBarColor: kBlackColor,
    ));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NowPlayingPageController>(context, listen: false)
          .initState(widget.count);
    });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 47, 46, 46),
      statusBarColor: Color.fromARGB(255, 72, 22, 0),
    ));

    final nowPlayingController = context.watch<NowPlayingPageController>();
    final currentIndex = nowPlayingController.cuttentIndex;
    final duration = nowPlayingController.duration;
    final position = nowPlayingController.position;
    final firstSong = nowPlayingController.firstSong;
    final lastSong = nowPlayingController.lastSong;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 72, 22, 0),
                Color.fromARGB(255, 143, 63, 29),
                Color.fromARGB(255, 47, 46, 46),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        SystemChrome.setSystemUIOverlayStyle(
                          const SystemUiOverlayStyle(
                            systemNavigationBarColor:
                                Color.fromARGB(255, 47, 46, 46),
                            statusBarColor: kBlackColor,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: kWhiteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                QueryArtworkWidget(
                  id: widget.songModel[currentIndex].id,
                  type: ArtworkType.AUDIO,
                  keepOldArtwork: true,
                  artworkWidth: MediaQuery.of(context).size.width * 3.8 / 5,
                  artworkBorder: BorderRadius.circular(10),
                  artworkHeight: MediaQuery.of(context).size.width * 3.8 / 5,
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: SizedBox(
                    height: MediaQuery.of(context).size.width * 3.8 / 5,
                    width: MediaQuery.of(context).size.width * 3.8 / 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/Headset.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.6 / 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextScroll(
                        '${widget.songModel[currentIndex].displayNameWOExt}                     ',
                        velocity: const Velocity(
                          pixelsPerSecond: Offset(40, 0),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor,
                        ),
                        textAlign: TextAlign.center,
                        mode: TextScrollMode.endless,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.songModel[currentIndex].artist.toString() ==
                                '<unknown>'
                            ? "Unknown Artist"
                            : widget.songModel[currentIndex].artist.toString(),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MusicSliderWidget(
                  duration: duration,
                  position: position,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.57 / 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nowPlayingController.formatPosition,
                        style: const TextStyle(
                          color: kWhiteColor,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        nowPlayingController.formatDuration,
                        style: const TextStyle(
                          color: kWhiteColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MusicBottomButtons(
                  songModel: widget.songModel[currentIndex],
                  firstsong: firstSong,
                  lastsong: lastSong,
                  count: widget.count,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
