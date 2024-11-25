import 'package:flutter/material.dart';
import 'package:smart_iot/common/helpers/is_dark_mode.dart';
import 'package:smart_iot/common/widgets/appbar/app_bar.dart';

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

  Widget _profileInfo(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/2.3,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xff2C2B2B) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
      ),
    );
  }
}
