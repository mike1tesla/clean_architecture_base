import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/domain/usecase/song/get_favorite_songs.dart';
import '../../../domain/entities/song/song.dart';
import '../../../service_locator.dart';

part 'favorite_songs_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var songs = await sl<GetFavoriteSongUseCase>().call();
    songs.fold(
      (l) {
        emit(FavoriteSongsFailure());
      },
      (r) {
        favoriteSongs = r;
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      },
    );
  }
  void removeSong(int index){
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}
