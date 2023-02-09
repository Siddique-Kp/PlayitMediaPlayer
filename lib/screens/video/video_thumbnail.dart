import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

late String thumbnailFile;
final videoInfo = FlutterVideoInfo();

Future<String> getthumbnail(path) async {
  return thumbnailFile = (await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG))!;
}

Widget thumbnail({required path, context, duration}) {
  return Stack(
    children: [
      Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.25,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FutureBuilder(
            future: getthumbnail(path),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String data = snapshot.data!;
                return Image.file(
                  File(data),
                  fit: BoxFit.cover,
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(3)),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: const Center(
                    child: Icon(Icons.smart_display, size: 30),
                  ),
                );
              }
            },
          )),
       Positioned(
          right: 1,
          bottom: 1,
          child: Card(
            color:const Color.fromARGB(116, 0, 0, 0),
            child: duration!=null?
            Text(
               duration.toString().split('0:0').last,
              style: const TextStyle(color: Colors.white, fontSize: 11.0),
            ):null
            ,
          ))
    ],
  );
}

String formatDuration(Duration d) {
  int minute = d.inMinutes;
  int second = (d.inSeconds > 59) ? (d.inSeconds % 60) : d.inSeconds;
  String format =
      "${(minute < 10) ? "0$minute" : "$minute"}:${(second < 10) ? "0$second" : "$second"}";
  return format;
}

fileSize(path) {
  final fileSizeInBytes = File(path).lengthSync();
  if (fileSizeInBytes < 1024) {
    return '$fileSizeInBytes bytes';
  }
  if (fileSizeInBytes < 1048576) {
    return '${(fileSizeInBytes / 1024).toStringAsFixed(1)}KB';
  }
  if (fileSizeInBytes < 1073741824) {
    return '${(fileSizeInBytes / 1048576).toStringAsFixed(1)}MB';
  }
  return '${(fileSizeInBytes / 1073741824).toStringAsFixed(1)}GB';
}


