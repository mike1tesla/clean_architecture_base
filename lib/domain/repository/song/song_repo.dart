import 'package:dartz/dartz.dart';

abstract class SongsRepository{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoritesSong(String songId);
  Future<Either> getUserFavoriteSong();
}