import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:semb_assignment/features/home_screen/screen/home_screen.dart';

import 'package:semb_assignment/core/utils/hive_controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveControllers.registerHive();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Semb AI',
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 241, 205, 95)),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      );
    });
  }
}
