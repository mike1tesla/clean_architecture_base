import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/domain/usecase/song/get_news_songs.dart';

import '../../../service_locator.dart';
import 'news_songs_state.dart';

class NewsSongCubit extends Cubit<NewsSongsState> {
  NewsSongCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (data) {
        emit(NewsSongsLoaded(songs: data));
      },
    );
  }
}
