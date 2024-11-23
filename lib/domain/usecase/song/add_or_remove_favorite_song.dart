import 'package:dartz/dartz.dart';
import 'package:smart_iot/core/usecase/usecase.dart';
import 'package:smart_iot/domain/repository/song/song_repo.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String ? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}

