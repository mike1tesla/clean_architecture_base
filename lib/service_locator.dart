import 'package:get_it/get_it.dart';
import 'package:smart_iot/data/data_source/auth/auth_firebase_service.dart';
import 'package:smart_iot/data/data_source/mess/mess_gemini_service.dart';
import 'package:smart_iot/data/data_source/song/song_firebase_service.dart';
import 'package:smart_iot/data/repository/auth/auth_repo_impl.dart';
import 'package:smart_iot/data/repository/mess/mess_repo_impl.dart';
import 'package:smart_iot/data/repository/song/song_repo_impl.dart';
import 'package:smart_iot/domain/repository/auth/auth_repo.dart';
import 'package:smart_iot/domain/repository/mess/mess_repo.dart';
import 'package:smart_iot/domain/repository/song/song_repo.dart';
import 'package:smart_iot/domain/usecase/auth/get_user.dart';
import 'package:smart_iot/domain/usecase/auth/is_logged_in.dart';
import 'package:smart_iot/domain/usecase/auth/signin.dart';
import 'package:smart_iot/domain/usecase/auth/signup.dart';
import 'package:smart_iot/domain/usecase/song/add_or_remove_favorite_song.dart';
import 'package:smart_iot/domain/usecase/song/get_news_songs.dart';
import 'package:smart_iot/domain/usecase/song/get_play_list.dart';
import 'package:smart_iot/domain/usecase/song/is_favorite_song.dart';

import 'domain/usecase/auth/signout.dart';
import 'domain/usecase/mess/call_gemini_model.dart';
import 'domain/usecase/song/get_favorite_songs.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // data source
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<MessageGeminiService>(MessageGeminiServiceImpl());

  // repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  sl.registerSingleton<MessageRepository>(MessageRepositoryImpl());

  // Domain - Use Case
  // auth
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  // song
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(AddOrRemoveFavoriteSongUseCase());
  sl.registerSingleton<IsFavoritesSongUseCase>(IsFavoritesSongUseCase());
  sl.registerSingleton<GetFavoriteSongUseCase>(GetFavoriteSongUseCase());
  // mess
  sl.registerSingleton<CallGeminiModelUseCase>(CallGeminiModelUseCase());
}
