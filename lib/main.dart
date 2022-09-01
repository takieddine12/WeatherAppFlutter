import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/notifiers/theme_notifier.dart';
import 'package:weather_app/views/splash_view.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (context) => ThemeNotifier(),
    child: const GetMaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}



