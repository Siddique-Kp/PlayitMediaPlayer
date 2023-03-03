import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({
    Key? key,
    required this.songModel,
    required this.size,
  }) : super(key: key);

  final SongModel songModel;
  final double size;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: songModel.id,
      type: ArtworkType.AUDIO,
      keepOldArtwork: true,
      artworkBorder: BorderRadius.circular(3),
      artworkHeight: size,
      artworkWidth: size,
      artworkFit: BoxFit.cover,
      nullArtworkWidget: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(3),
        ),
        width: size,
        height: size,
        child: const Center(
            child: Icon(
          Icons.music_note,
          color: Colors.white,
        )),
      ),
    );
  }
}