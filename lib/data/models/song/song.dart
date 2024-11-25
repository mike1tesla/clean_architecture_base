import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_iot/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;

  // Method fromJson
  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];

    // Kiểm tra và chuyển đổi duration sang kiểu num
    var rawDuration = data['duration'];
    if (rawDuration is String) {
      duration = num.tryParse(rawDuration);
    } else if (rawDuration is num) {
      duration = rawDuration;
    }
    releaseDate = data['releaseDate'];
  }
}

// Mở rộng Extention chuyển SongModel => SongEntity
extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
      isFavorite: isFavorite!,
      songId: songId!,
    );
  }
}
