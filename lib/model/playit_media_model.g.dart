// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playit_media_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayItSongModelAdapter extends TypeAdapter<PlayItSongModel> {
  @override
  final int typeId = 1;

  @override
  PlayItSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayItSongModel(
      name: fields[0] as String,
      songId: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayItSongModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.songId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayItSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoFavoriteModelAdapter extends TypeAdapter<VideoFavoriteModel> {
  @override
  final int typeId = 3;

  @override
  VideoFavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoFavoriteModel(
      title: fields[0] as String,
      videoPath: fields[1] as String,
      videoSize: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoFavoriteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.videoPath)
      ..writeByte(2)
      ..write(obj.videoSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoFavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoPlaylistModelAdapter extends TypeAdapter<VideoPlaylistModel> {
  @override
  final int typeId = 4;

  @override
  VideoPlaylistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoPlaylistModel(
      name: fields[0] as String,
      index: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoPlaylistModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoPlaylistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AllVideosAdapter extends TypeAdapter<AllVideos> {
  @override
  final int typeId = 5;

  @override
  AllVideos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllVideos(
      duration: fields[0] as String,
      path: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AllVideos obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllVideosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoPlayListItemAdapter extends TypeAdapter<VideoPlayListItem> {
  @override
  final int typeId = 6;

  @override
  VideoPlayListItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoPlayListItem(
      videoPath: fields[0] as String,
      playlistFolderindex: fields[1] as int,
      duration: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoPlayListItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.videoPath)
      ..writeByte(1)
      ..write(obj.playlistFolderindex)
      ..writeByte(2)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoPlayListItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
