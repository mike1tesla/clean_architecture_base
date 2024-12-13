import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/common/bloc/favorite_button/favorite_button_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';
import '../../../service_locator.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;

  const FavoriteButton({super.key, required this.songEntity, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteButtonCubit>(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () async {
                await context.read<FavoriteButtonCubit>().favoriteButtonUpdate(songEntity.songId);
                if(function != null){
                  function!();
                }
              },
              icon: Icon(
                songEntity.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                size: 30,
                color: AppColors.darkGrey,
              ),
            );
          }
          if (state is FavoriteButtonUpdate) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdate(songEntity.songId);
              },
              icon: Icon(
                state.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                size: 30,
                color: AppColors.darkGrey,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
