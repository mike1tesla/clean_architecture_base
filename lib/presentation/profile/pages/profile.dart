import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/common/helpers/is_dark_mode.dart';
import 'package:smart_iot/common/widgets/appbar/app_bar.dart';
import 'package:smart_iot/core/configs/theme/app_colors.dart';
import 'package:smart_iot/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:smart_iot/presentation/profile/bloc/profile_cubit.dart';
import 'package:smart_iot/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/constants/app_urls.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: context.isDarkMode ? const Color(0xff2C2B2B) : const Color(0xFFF9F9F9),
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(height: 20),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit()..getUser(),
      child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.isDarkMode ? const Color(0xff2C2B2B) : const Color(0xFFF9F9F9),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50))),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(state.userEntity.imageURL!)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.userEntity.email!,
                      style: const TextStyle(
                          color: AppColors.grey, fontSize: 15, fontFamily: 'Satoshi', fontWeight: FontWeight.w400),
                    ),
                    Text(
                      state.userEntity.fullName!,
                      style: const TextStyle(fontSize: 22, fontFamily: 'Satoshi', fontWeight: FontWeight.w700),
                    ),
                  ],
                );
              }
              if (state is ProfileFailure) {
                return const Text('Please try again');
              }
              return Container();
            },
          )),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider<FavoriteSongsCubit>(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Favorite Songs"),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SongPlayerPage(songEntity: state.favoriteSongs[index]),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${AppURLs.coverFirestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpg?${AppURLs.mediaAlt}'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.favoriteSongs[index].title,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(height: 10),
                                    Text(state.favoriteSongs[index].artist,
                                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(state.favoriteSongs[index].duration.toString().replaceAll('.', ':')),
                                const SizedBox(width: 20),
                                FavoriteButton(
                                  songEntity: state.favoriteSongs[index],
                                  key: UniqueKey(),
                                  function: () {
                                    context.read<FavoriteSongsCubit>().removeSong(index);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return const Text("ERROR");
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
