import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  late final StreamSubscription<Duration> positionSubscription;
  late final StreamSubscription<Duration?> durationSubscription;

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    // Vị trí hiện tại bài hát
    positionSubscription = audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });
    // Thời lượng bài hát
    durationSubscription = audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
      }
    });
  }

  Future<void> seekToSec(double position) async {
    final newPosition = Duration(seconds: position.toInt());
    await audioPlayer.seek(newPosition);
    emit(SongPlayerLoaded());
  }

  void updateSongPlayer() {
    if (!isClosed) {
      emit(SongPlayerLoaded());
    }
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    if (!isClosed) {
      emit(SongPlayerLoaded());
    }
  }

  @override
  Future<void> close() {
    // Hủy các subscription
    positionSubscription.cancel();
    durationSubscription.cancel();
    audioPlayer.dispose();
    return super.close();
  }
}
