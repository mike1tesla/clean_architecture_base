import 'package:dartz/dartz.dart';
import 'package:smart_iot/data/data_source/song/song_firebase_service.dart';
import 'package:smart_iot/domain/repository/song/song_repo.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongsRepository {

  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoritesSong(String songId) async {
    return await sl<SongFirebaseService>().isFavoritesSong(songId);
  }
}