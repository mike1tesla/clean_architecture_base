import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/common/helpers/is_dark_mode.dart';
import 'package:smart_iot/core/configs/theme/app_colors.dart';
import 'package:smart_iot/core/constants/app_urls.dart';
import 'package:smart_iot/presentation/home/bloc/news_songs_cubit.dart';
import 'package:smart_iot/presentation/home/bloc/news_songs_state.dart';

import '../../../domain/entities/song/song.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Khi tạo NewsSongsCubit thì thực hiện luôn hành động getNewsSong()
      create: (context) => NewsSongsCubit()..getNewsSongs(),
      child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
        builder: (context, state) {
          if (state is NewsSongsLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          if (state is NewsSongsLoaded) {
            return songs(state.songs);
          }
          return Container();
        },
      ),
    );
  }

  Widget songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '${AppURLs.firestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppURLs.mediaAlt}'),
                      )),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 35,
                      height: 35,
                      transform: Matrix4.translationValues(-5, 10, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode ? AppColors.darkGrey : const Color(0xFFE6E6E6),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.isDarkMode ?  const Color(0xff959595) : const Color(0xff555555),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(songs[index].title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              Text(songs[index].artist, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 14);
      },
      itemCount: songs.length,
    );
  }
}
