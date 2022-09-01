import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/moor/city_history.dart';
import 'package:weather_app/notifiers/theme_notifier.dart';
import 'package:weather_app/views/main_view.dart';

import '../notifiers/storage_manager.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    initPrefs();
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
      builder: (context , provider , child){
        return MaterialApp(
          theme: provider.getTheme(),
          home: SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Search History",style: TextStyle(fontFamily: "makuta_bold",fontSize: 20),),
                  ),
                  Expanded(
                    child: FutureBuilder<List<HistoryData>>(
                      future: AppDatabase().getHistory(),
                      builder: (context,data){
                        if(data.hasError){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else {
                          return ListView.builder(
                            itemCount:  data.data!.length,
                            itemBuilder: (context,index){
                              if(data.data != null){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.off(() => HomeView(
                                        latitude: double.parse(data.data![index].latitude.toString()),
                                        longitude: double.parse(data.data![index].longitude.toString()),
                                      ));
                                    },
                                    child: Card(
                                      elevation: 4,
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children : [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("City : ${data.data![index].city}",style: const TextStyle(
                                                  fontSize: 20,fontFamily: 'makuta_bold'
                                              ),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 5,left: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: isDarkMode ? Colors.blueAccent : Colors.orange,
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,right: 8),
                                                  child: Text("Latitude : ${data.data![index].latitude}",style: const TextStyle(
                                                      fontSize: 15,fontFamily: 'makuta_bold'
                                                  )),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 5,left: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: isDarkMode ? Colors.orange : Colors.blueAccent,
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child : Padding(
                                                    padding: const EdgeInsets.only(left: 8,right: 8),
                                                    child: Text("Longitude : ${data.data![index].longitude}",style: const TextStyle(
                                                        fontSize: 15,fontFamily: 'makuta_bold'
                                                    ))),
                                              ),
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                );
                              }
                              else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

