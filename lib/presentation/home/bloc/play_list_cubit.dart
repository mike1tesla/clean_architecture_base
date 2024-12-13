import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/domain/usecase/song/get_play_list.dart';
import 'package:smart_iot/presentation/home/bloc/play_list_state.dart';

import '../../../service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  void getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    print(returnedSongs);
    returnedSongs.fold(
      (l) {
        emit(PlayListFailure());
      },
      (data) {
        emit(PlayListLoaded(songs: data));
      },
    );
  }
}
