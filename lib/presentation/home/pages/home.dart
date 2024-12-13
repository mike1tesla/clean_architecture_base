import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_iot/common/helpers/is_dark_mode.dart';
import 'package:smart_iot/core/configs/assets/app_images.dart';
import 'package:smart_iot/core/configs/theme/app_colors.dart';
import 'package:smart_iot/presentation/profile/pages/profile.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/configs/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        backgroundColor: Colors.green.shade100,
        action: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
          icon: const Icon(Icons.person),
        ),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 110,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            Align(alignment: Alignment.bottomCenter, child: SvgPicture.asset(AppVectors.homeTopCard)),
            Align(alignment: Alignment.bottomCenter, child: Image.asset(AppImages.homeArtist)),
          ],
        ),
      ),
    );
  }
}
