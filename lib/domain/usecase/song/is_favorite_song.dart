import 'package:smart_iot/core/usecase/usecase.dart';
import 'package:smart_iot/domain/repository/song/song_repo.dart';

import '../../../service_locator.dart';

class IsFavoritesSongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String ? params}) async {
    return await sl<SongsRepository>().isFavoritesSong(params!);
  }
}

