part of 'favorite_button_cubit.dart';

abstract class FavoriteButtonState {}

class FavoriteButtonInitial extends FavoriteButtonState {

}

class FavoriteButtonUpdate extends FavoriteButtonState{
  final bool isFavorite;

  FavoriteButtonUpdate({required this.isFavorite});
}
