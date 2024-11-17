import 'package:dartz/dartz.dart';
import 'package:smart_iot/core/usecase/usecase.dart';
import '../../../data/repository/song/song_repo_impl.dart';
import '../../../service_locator.dart';

class GetNewsSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepositoryImpl>().getNewsSongs();
  }

}