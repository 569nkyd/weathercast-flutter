import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathercast/model/weather_model.dart';
import 'package:weathercast/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('ce21d540aa6783bd2e666916bc5e6799');
  Weather? _weather;
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null) return'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case'rain':
      case'drizzle':
      case'shower rain':
        return 'assets/rain.json';
      case"thunderstorm":
        return 'assets/thunder.json';
        return 'assets/thunder.json';
      case"clear":
        return'sunny.json';
      default:
        return 'assets/sunny.json';

    }
  }
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12
      ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),

            Text(_weather?.mainCondition ?? "",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
