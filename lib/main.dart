import 'package:anime_sync/services/injection_container.dart';
import 'package:anime_sync/src/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(383, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Anime sync',
          theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            fontFamily: 'poppins',
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const HomePage(),
        );
      },
    );
  }
}
