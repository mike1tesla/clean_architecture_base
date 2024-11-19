import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_iot/common/helpers/is_dark_mode.dart';
import 'package:smart_iot/core/configs/assets/app_images.dart';
import 'package:smart_iot/core/configs/theme/app_colors.dart';
import 'package:smart_iot/presentation/home/widgets/news_songs.dart';

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
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 230,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            )
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

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      physics: const ClampingScrollPhysics(),
      tabAlignment: TabAlignment.center,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      indicatorColor: AppColors.primary,
      dividerColor: Colors.transparent,
      tabs: const [
        Text("News", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        Text("Video", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        Text("Artists", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        Text("Podcast", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
      ],
    );
  }
}
