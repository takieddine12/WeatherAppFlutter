import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/notifiers/theme_notifier.dart';
import 'package:weather_app/views/main_view.dart';

import '../notifiers/storage_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var isInProgress = true;
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    initPrefs();
    Future.delayed(const Duration(seconds: 10),(){
        setState(() {
           isInProgress = false;
        });
        Get.off(() => HomeView());
    });
  }

  void initPrefs()  {
    StorageManager.getTheme().then((value){
      if(value == "dark"){
        setState(() {
          isDarkMode = true;
        });
      } else {
        setState(() {
          isDarkMode = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context,provider,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: provider.getTheme(),
            home: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.asset("assets/gifs/weather.gif",height: 180,width: 180,)),
                  const SizedBox(height: 80,),
                  Visibility(
                    visible: isInProgress,
                    child: CircularProgressIndicator(color: isDarkMode ? Colors.blueAccent : Colors.orange,),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
