import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playit/screens/music/playing_music/music_bottom_buttons.dart';
import 'package:playit/screens/music/playing_music/music_slider.dart';
import 'package:text_scroll/text_scroll.dart';
import '../get_all_songs.dart';

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
  Duration _duration = const Duration();
  Duration _position = const Duration();
  int currentIndex = 0;
  bool firstSong = false;
  bool lastSong = false;
  int large = 0;
  // static TextStyle timerStyle = const TextStyle(
  //   color: Colors.red,
  //   fontWeight: FontWeight.w900,
  // );

  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        GetAllSongController.currentIndexes = index;
        if (mounted) {
          setState(() {
            large = widget.count - 1; //store the last song's index number
            currentIndex = index;
            index == 0 ? firstSong = true : firstSong = false;
            index == large ? lastSong = true : lastSong = false;
          });
        }
      }
    });
    deviceOrientation();
    super.initState();
    playSong();
  }

  deviceOrientation() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  playSong() {
    // try {
    //   widget.audioPlayer.setAudioSource(
    //     AudioSource.uri(
    //       Uri.parse(widget.songModel.uri!),
    //       tag: MediaItem(
    //         id: widget.songModel.id.toString(),
    //         album: widget.songModel.album,
    //         title: widget.songModel.displayNameWOExt,
    //         artUri: Uri.parse('https://example.com/albumart.jpg'),
    //       ),
    //     ),
    //   );}

    // GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((d) {
      if (mounted) {
        setState(() {
          if (d != null) {
            _duration = d;
          }
        });
      }
    });
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 47, 46, 46),
      statusBarColor: Colors.black,
    ));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 47, 46, 46),
      statusBarColor: Color.fromARGB(255, 72, 22, 0),
    ));
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
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
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.6 / 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextScroll(
                          '${widget.songModel[currentIndex].displayNameWOExt}                     ',
                          velocity:
                              const Velocity(pixelsPerSecond: Offset(40, 0)),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          mode: TextScrollMode.endless,
                          // pauseBetween: const Duration(seconds: 2),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.songModel[currentIndex].artist.toString() ==
                                  '<unknown>'
                              ? "Unknown Artist"
                              : widget.songModel[currentIndex].artist
                                  .toString(),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                MusicSliderWidget(duration: _duration, position: _position),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.57 / 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Text(
                        _formatDuration(_duration),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MusicBottomButtons(
                  favSongModel: widget.songModel[currentIndex],
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

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }
}
