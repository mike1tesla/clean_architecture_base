import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/common/helpers/is_dark_mode.dart';
import 'package:smart_iot/core/configs/theme/app_colors.dart';
import 'package:smart_iot/presentation/home/bloc/play_list_cubit.dart';
import 'package:smart_iot/presentation/home/bloc/play_list_state.dart';
import 'package:smart_iot/presentation/song_player/pages/song_layer.dart';

import '../../../domain/entities/song/song.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          if (state is PlayListLoaded) {
            return Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Playlist", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    Text(
                      'See More',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFC5C5C5),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                _playlistSongs(state.songs),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _playlistSongs(List<SongEntity> songs) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SongPlayerPage(songEntity: songs[index],),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 37,
                    height: 37,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode ? const Color(0xFF2B2B2B) : const Color(0xFFE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(songs[index].title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(songs[index].artist, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(songs[index].duration.toString().replaceAll('.', ':')),
                  const SizedBox(width: 50),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 30,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 20);
      },
      itemCount: songs.length,
    );
  }
}
