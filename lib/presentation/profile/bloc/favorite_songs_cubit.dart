import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_songs_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsInitial());
}
