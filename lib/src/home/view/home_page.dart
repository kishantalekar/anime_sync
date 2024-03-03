// ignore_for_file: avoid_print

import 'package:anime_sync/core/constants/assets.dart';
import 'package:anime_sync/core/theme/colors.dart';
import 'package:anime_sync/services/injection_container.dart';
import 'package:anime_sync/src/chat/view/chat_page.dart';
import 'package:anime_sync/src/countdown/view/countdown_page.dart';
import 'package:anime_sync/src/home/home.dart';
import 'package:anime_sync/src/home/widgets/widgets_imports.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';

/// {@template home_page}
/// A description for HomePage
/// {@endtemplate}
///

class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  /// The static route for HomePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: const Scaffold(
        body: HomeView(),
      ),
    );
  }
}

const List<TabItem> items = [
  TabItem(
    icon: Icons.chat_bubble,
    // title: 'chat',
  ),
  TabItem(
    icon: Icons.hourglass_bottom,
    // title: 'Countdown',
  ),
  TabItem(
    icon: Icons.home,
    // title: 'Home',
  ),
];

/// {@template home_view}
/// Displays the Body of HomeView
/// {@endtemplate}
class HomeView extends StatefulWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int visit = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.backgroundColor,
        leading: Image.asset(
          Assets.assetsImagesAppLogo,
          color: TColors.primaryColor,
        ),
        title: const Text(
          "Ani Sync",
          style: TextStyle(
            color: TColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: IndexedStack(
          index: visit,
          children: const [ChatPage(), HomeBody(), CountdownPage()]),
      bottomNavigationBar: BottomBarDefault(
        items: items,
        backgroundColor: TColors.backgroundColor,
        color: Colors.white,
        colorSelected: TColors.primaryColor,
        indexSelected: visit,
        paddingVertical: 25,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
