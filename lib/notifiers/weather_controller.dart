
import 'package:get/get.dart';
import 'package:weather_app/auth/web_auth.dart';
import 'package:weather_app/models/CurrentWeatherModel.dart';
import 'package:weather_app/models/five_days/FiveDaysWeatherModel.dart';

class WeatherController extends GetxController {

  late WebService webService;
  CurrentWeatherModel? currentWeatherModel;
  FiveDaysWeatherModel? fiveDaysWeatherModel;


  @override
  void onInit() {
    super.onInit();
    webService = WebService();
  }

  void getCurrentWeather(double lat , double lon){
     webService.getCurrentWeather(lat, lon).then((value){
       currentWeatherModel = value!;
       update();
     });
  }
  void getFiveDaysWeather(double lat , double lon){
     webService.getSevenDaysWeather(lat, lon).then((value){
       fiveDaysWeatherModel = value!;
       update();
     });
  }

}