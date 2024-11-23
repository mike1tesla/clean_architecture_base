import 'package:get_it/get_it.dart';
import 'package:smart_iot/data/data_source/auth/auth_firebase_service.dart';
import 'package:smart_iot/data/data_source/song/song_firebase_service.dart';
import 'package:smart_iot/data/repository/auth/auth_repo_impl.dart';
import 'package:smart_iot/data/repository/song/song_repo_impl.dart';
import 'package:smart_iot/domain/repository/auth/auth_repo.dart';
import 'package:smart_iot/domain/repository/song/song_repo.dart';
import 'package:smart_iot/domain/usecase/auth/signin.dart';
import 'package:smart_iot/domain/usecase/auth/signup.dart';
import 'package:smart_iot/domain/usecase/song/add_or_remove_favorite_song.dart';
import 'package:smart_iot/domain/usecase/song/get_news_songs.dart';
import 'package:smart_iot/domain/usecase/song/get_play_list.dart';
import 'package:smart_iot/domain/usecase/song/isFavoritesSong.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // data source
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImpl()
  );

  // repository
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<SongsRepository>(
      SongRepositoryImpl()
  );

  // Domain - Use Case
  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );

  sl.registerSingleton<GetNewsSongsUseCase>(
      GetNewsSongsUseCase()
  );

  sl.registerSingleton<GetPlayListUseCase>(
      GetPlayListUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase()
  );

  sl.registerSingleton<IsFavoritesSongUseCase>(
      IsFavoritesSongUseCase()
  );

}