part of 'song_player_cubit.dart';

@immutable
sealed class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {

}

class SongPlayerFailure extends SongPlayerState {}
