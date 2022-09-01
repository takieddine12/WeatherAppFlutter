
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/moor/city_history.dart';
import 'package:weather_app/notifiers/storage_manager.dart';
import 'package:weather_app/notifiers/theme_notifier.dart';
import 'package:weather_app/notifiers/weather_controller.dart';
import 'package:weather_app/views/history_view.dart';

class HomeView extends StatefulWidget {
  double? latitude;
  double? longitude;
  HomeView({Key? key, this.latitude ,  this.longitude}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SharedPreferences? _sharedPreferences;
  final Location _location = Location();
  LocationData? _locationData;
  bool _isServiceEnabled = false;
  PermissionStatus? _permissionGranted;
  double latitude = 51.5072;
  double longitude = 0.1276;
  bool isDarkMode = false;
  late WeatherController weatherController;
  final TextEditingController _weatherController = TextEditingController();
  final _editKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    weatherController = Get.put(WeatherController());
    isPermissionGranted();
    initPrefs();
    if(widget.latitude != null &&  widget.longitude != null){
      setState(() {
        setState(() {
          latitude = widget.latitude!;
          longitude = widget.longitude!;
        });
      });
    }
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

  void isPermissionGranted() async {
    _isServiceEnabled = await _location.serviceEnabled();
    if(!_isServiceEnabled){
      _isServiceEnabled = await _location.requestService();
      if(!_isServiceEnabled){
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if(_permissionGranted ==  PermissionStatus.denied){
      _permissionGranted  = await _location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }
    _locationData = await _location.getLocation();
    setState(() {
      latitude = _locationData!.latitude!;
      longitude = _locationData!.longitude!;
    });

  }

  @override
  Widget build(BuildContext context) {
    weatherController.getCurrentWeather(latitude, longitude);
    weatherController.getFiveDaysWeather(latitude, longitude);
    return Consumer<ThemeNotifier>(
        builder: (context,provider,child){
           return MaterialApp(
             debugShowCheckedModeBanner: false,
             theme: provider.getTheme(),
             home: SafeArea(
               child: Scaffold(
                 drawer: Drawer(
                   child: Column(
                     children:  [
                        DrawerHeader(
                         child: Center(
                           child: Image.asset("assets/images/weather_icon.png",height: 150,width: 150,),),
                       ),
                        Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SwitchListTile(
                                 title: const Text("Light / Dark",style: TextStyle(fontFamily: 'makuta_medium',
                                     fontSize: 17),),
                                 value: isDarkMode,
                                 activeColor: isDarkMode ? Colors.orange : Colors.black12,
                                 onChanged: (value){
                                   if(value){
                                     setState(() {
                                       isDarkMode = true;
                                       StorageManager.saveTheme("dark");
                                       provider.setDarkMode();
                                     });
                                   } else {
                                     setState(() {
                                       isDarkMode = false;
                                       StorageManager.saveTheme("light");
                                       provider.setLightMode();
                                     });
                                   }
                                 }),
                             const Divider(),
                             Padding(
                               padding: const EdgeInsets.only(left: 10,top: 5),
                               child: Builder(
                                 builder: (context){
                                   return GestureDetector(
                                     onTap: (){
                                       Scaffold.of(context).closeDrawer();
                                       Get.to(() => const HistoryView());
                                     },
                                     child: const Text("City History",style: TextStyle(fontSize: 17,fontFamily: "makuta_medium"),
                                     ),
                                   );
                                 },
                               )
                             ),
                             const Divider()
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
                 body: Stack(
                   children: [
                     ClipRRect(
                       borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                       child: isDarkMode ?  Image.asset("assets/images/night_bg.jpg", width: double.infinity,
                         height: 250,fit:
                         BoxFit.cover,)
                           :  Image.asset("assets/images/weather_bg.jpg", width: double.infinity,
                         height: 250,fit:
                         BoxFit.cover,),
                     ),
                     Column(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 10,left: 20),
                               child: Builder(
                                 builder: (context){
                                   return IconButton(
                                       onPressed: (){
                                         Scaffold.of(context).openDrawer();
                                       },
                                       icon: isDarkMode ? Image.asset("assets/images/view_icon.png",height: 20,width: 20,
                                         color: Colors.white,)
                                           : Image.asset("assets/images/view_icon.png",height: 20,width: 20,
                                         color: Colors.black,));
                                 },
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 30,right: 30,top: 8),
                               child: Form(
                                 key: _editKey,
                                 child: TextFormField(
                                   controller: _weatherController,
                                   style: const TextStyle(color: Colors.white),
                                   validator: (value){
                                     if(value!.isEmpty){
                                       return "Please insert a ciy ..";
                                     }
                                     return null;
                                   },
                                   decoration: InputDecoration(
                                       hintText: "City",
                                       suffixIcon:  IconButton(onPressed: () async{
                                         var isEditValidated = _editKey.currentState!.validate();
                                         if(isEditValidated){
                                           var geoCoder = await GeocoderBuddy.query(_weatherController.text);
                                           setState(() {
                                             latitude  = double.parse(geoCoder.last.lat);
                                             longitude = double.parse(geoCoder.last.lon);
                                           });
                                           AppDatabase().insertHistory(HistoryData(
                                               id: DateTime.now().millisecondsSinceEpoch,
                                               city: _weatherController.text,
                                               latitude: latitude.toInt(),
                                               longitude: longitude.toInt()));

                                           _weatherController.clear();
                                           FocusManager.instance.primaryFocus?.unfocus();
                                         }
                                       },icon: const Icon(Icons.search),),
                                       hintStyle: const TextStyle(fontStyle: FontStyle.italic,fontSize: 14,fontFamily: 'makuta_medium'),
                                       contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                       enabledBorder : OutlineInputBorder(
                                           borderSide:  BorderSide(
                                               color: isDarkMode ? Colors.white : Colors.black,
                                               width: 1,
                                               style: BorderStyle.solid
                                           ),
                                           borderRadius: BorderRadius.circular(6)
                                       )
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Expanded(
                           child: SingleChildScrollView(
                             child: GetBuilder<WeatherController>(
                               init: weatherController,
                               builder: (controller){
                                 if(controller.currentWeatherModel != null){
                                   var data = controller.currentWeatherModel;
                                   return Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children:  [
                                       Padding(
                                         padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                                         child: SizedBox(
                                           width: double.infinity,
                                           child: Card(
                                             shape: const RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.all(Radius.circular(20))
                                             ),
                                             child: Column(
                                               mainAxisSize: MainAxisSize.min,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(top: 10),
                                                   child: Text(data!.name!,style: const TextStyle(
                                                       fontSize: 20,
                                                       fontFamily: "makuta_bold"),),
                                                 ),
                                                 Text(weatherDate(data.dt!),style: const TextStyle(fontFamily: 'makuta_medium',fontSize: 17),),
                                                 const SizedBox(height: 10,),
                                                 Row(
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 20,right: 20),
                                                       child: Column(
                                                         children: [
                                                           Text(data.weather![0].description!,style: const TextStyle(fontSize: 20, fontFamily: 'makuta_bold',),),
                                                           Text("${data.main!.temp}°C",style: const TextStyle(fontSize: 25, fontFamily: 'makuta_medium'),),
                                                           const SizedBox(height: 5,),
                                                           Text("Min ${data.main!.tempMin} °C" , style: const TextStyle(fontFamily: 'makuta_medium'),),
                                                           Text("Max ${data.main!.tempMax}°C" , style: const TextStyle(fontFamily: 'makuta_medium'),),
                                                           Padding(
                                                             padding: const EdgeInsets.only(bottom: 10),
                                                             child: Text("wind ${data.wind!.speed} m/s"),
                                                           )
                                                         ],
                                                       ),
                                                     ),
                                                     Expanded(
                                                       child:  Padding(
                                                         padding: const EdgeInsets.only(left: 10,right: 10),
                                                         child: Image.network("http://openweathermap.org/img/wn/${data.weather![0].icon!}@4x.png",
                                                           fit: BoxFit.cover,),
                                                       ),
                                                     )
                                                   ],
                                                 )
                                               ],
                                             ),
                                           ),
                                         ),
                                       ),
                                       const Padding(
                                         padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                                         child: Text("Five Days Weather "  + "( 3 Hours Update )",style: TextStyle(
                                             fontFamily: 'makuta_bold',
                                             fontSize: 18
                                         ),),
                                       ),
                                       const SizedBox(height: 10,),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 10,right: 10),
                                         child: SizedBox(
                                           height: 140,
                                           child: GetBuilder<WeatherController>(
                                             init: weatherController,
                                             builder: (controller){
                                               if(controller.fiveDaysWeatherModel != null){
                                                 var data = controller.fiveDaysWeatherModel;
                                                 return ListView.builder(
                                                   scrollDirection: Axis.horizontal,
                                                   itemCount: data?.list!.length,
                                                   itemBuilder: (context,index){
                                                     return Card(
                                                       elevation: 4,
                                                       color: Colors.white,
                                                       shape: RoundedRectangleBorder(
                                                           borderRadius: BorderRadius.circular(8)
                                                       ),
                                                       child: Column(
                                                         children: [
                                                           Padding(
                                                             padding : const EdgeInsets.only(top : 5,left: 8,right: 8),
                                                             child: Text(data!.list![index].weather![0].main!,
                                                               style: const TextStyle(
                                                                   color: Colors.black54,
                                                                   fontFamily: "makuta_medium",
                                                                   fontSize: 17),),
                                                           ),
                                                           Padding(
                                                             padding: const EdgeInsets.only(left: 8,right: 8),
                                                             child: Image.network("http://openweathermap.org/img/w/${data.list![index].weather![0].icon!}.png",
                                                               height: 50,width: 50,fit: BoxFit.cover,),
                                                           ),
                                                           Padding(
                                                             padding: const EdgeInsets.only(left: 8,right: 8),
                                                             child: Text(data.list![index].main!.temp.toString(),style:
                                                             const TextStyle(color: Colors.black54,fontFamily: "makuta_medium"),),
                                                           )
                                                         ],
                                                       ),
                                                     );
                                                   },
                                                 );
                                               } else {
                                                 return const Text("");
                                               }
                                             },
                                           ),
                                         ),
                                       )
                                     ],
                                   );
                                 } else {
                                   return const Center(
                                     child: CircularProgressIndicator(color: Colors.orange,),
                                   );
                                 }
                               },
                             ),
                           ),
                         )
                       ],
                     )
                   ],
                 ),
               ),
             ),
           );
        });
  }
}

String weatherDate(int timestamp){
  DateFormat dateFormat = DateFormat("EEE, MMM d, ''yy");
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return dateFormat.format(dateTime).toString();
}

