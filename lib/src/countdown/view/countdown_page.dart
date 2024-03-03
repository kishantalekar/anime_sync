import 'package:flutter/material.dart';
import 'package:anime_sync/src/countdown/cubit/cubit.dart';
import 'package:anime_sync/src/countdown/widgets/countdown_body.dart';

/// {@template countdown_page}
/// A description for CountdownPage
/// {@endtemplate}
class CountdownPage extends StatelessWidget {
  /// {@macro countdown_page}
  const CountdownPage({super.key});

  /// The static route for CountdownPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const CountdownPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountdownCubit(),
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: CountdownView(),
      ),
    );
  }
}

/// {@template countdown_view}
/// Displays the Body of CountdownView
/// {@endtemplate}
class CountdownView extends StatelessWidget {
  /// {@macro countdown_view}
  const CountdownView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CountdownBody();
  }
}
