import 'package:dartz/dartz.dart';
import 'package:smart_iot/core/usecase/usecase.dart';
import 'package:smart_iot/domain/repository/song/song_repo.dart';
import '../../../service_locator.dart';

class GetPlayListUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getPlayList();
  }

}

