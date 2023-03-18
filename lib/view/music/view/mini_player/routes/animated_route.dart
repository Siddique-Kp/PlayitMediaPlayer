import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../now_playing/view/playing_music.dart';


  Route animatedRoute(List<SongModel> songModel) {
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
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
