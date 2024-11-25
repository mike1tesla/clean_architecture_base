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
      if (!isClosed) {
        songPosition = position;
        updateSongPlayer();
      }
    }, onError: (error) {
      // Bắt lỗi nếu cần
      if (!isClosed) emit(SongPlayerFailure());
    });

    // Thời lượng bài hát
    durationSubscription = audioPlayer.durationStream.listen((duration) {
      if (!isClosed && duration != null) {
        songDuration = duration;
      }
    }, onError: (error) {
      if (!isClosed) emit(SongPlayerFailure());
    });
  }

  Future<void> seekToSec(double position) async {
    if (!isClosed) {
      final newPosition = Duration(seconds: position.toInt());
      await audioPlayer.seek(newPosition);
      emit(SongPlayerLoaded());
    }
  }

  void updateSongPlayer() {
    if (!isClosed) {
      emit(SongPlayerLoaded());
    }
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      if (!isClosed) emit(SongPlayerLoaded());
    } catch (e) {
      if (!isClosed) emit(SongPlayerFailure());
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
    // Hủy các subscription trước khi đóng Cubit
    positionSubscription.cancel();
    durationSubscription.cancel();
    audioPlayer.dispose();
    return super.close();
  }
}
