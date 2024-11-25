import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_iot/common/helpers/is_dark_mode.dart';
import 'package:smart_iot/common/widgets/appbar/app_bar.dart';
import 'package:smart_iot/core/configs/theme/app_colors.dart';
import 'package:smart_iot/presentation/profile/bloc/profile_cubit.dart';

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
                      style: const TextStyle(color: AppColors.grey,fontSize: 15, fontFamily: 'Satoshi', fontWeight: FontWeight.w400),
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
}
