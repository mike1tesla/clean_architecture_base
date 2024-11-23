import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_iot/common/widgets/appbar/app_bar.dart';
import 'package:smart_iot/domain/entities/song/song.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/presentation/song_player/bloc/song_player_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../core/constants/app_urls.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;

  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SongPlayerCubit>(
      create: (context) => SongPlayerCubit()
        ..loadSong('${AppURLs.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppURLs.mediaAlt}'),
      child: Scaffold(
        appBar: BasicAppBar(
          title: const Text("Now Playing", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          action: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 30),
              _songDetail(),
              const SizedBox(height: 20),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              '${AppURLs.coverFirestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppURLs.mediaAlt}'),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(songEntity.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            Text(songEntity.artist, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14))
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border_outlined,
            size: 35,
            color: AppColors.darkGrey,
          ),
        )
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        } else if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                onChanged: (position) {
                  context.read<SongPlayerCubit>().seekToSec(position);
                },
                activeColor: AppColors.grey,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(context.read<SongPlayerCubit>().songPosition)),
                  Text(formatDuration(context.read<SongPlayerCubit>().songDuration)),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF42C73B),
                    shape: OvalBorder(),
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow_rounded,
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  // Format ve dang 00:00
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
