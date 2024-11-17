import 'package:dartz/dartz.dart';
import 'package:smart_iot/data/data_source/song/song_firebase_service.dart';
import 'package:smart_iot/domain/repository/song/song_repo.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongsRepository {

  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

}