import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/domain/usecase/song/add_or_remove_favorite_song.dart';
import '../../../service_locator.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdate(String songId) async {
    var result = await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songId);
    result.fold(
      (l) {},
      (isFavorite) {
        emit(FavoriteButtonUpdate(isFavorite: isFavorite));
      },
    );
  }
}
