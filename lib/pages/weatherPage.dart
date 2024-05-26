import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService('3cb4e3673840ccdfca141d5c29bd5666');
  Weather? _weather;

  Color bgcolor(String mainCondition) {
    if (mainCondition == 'assets/sunny.json') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  String getWeatherinfo(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    } // default to sunny
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        {
          return 'assets/cloudy.json';
        }

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        {
          return 'assets/rainy.json';
        }

      case 'thunderstorm':
        {
          return 'assets/thunder.json';
        }

      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  _fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();

    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
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
        backgroundColor: bgcolor(getWeatherinfo(_weather?.mainCondition)),
        body: Container(
          padding: const EdgeInsets.only(top: 40, bottom: 90),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Icon(Icons.location_on,
                    size: 30,
                    color: (bgcolor(getWeatherinfo(_weather?.mainCondition)) ==
                            Colors.white)
                        ? Colors.black
                        : Colors.white),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  _weather?.cityName.toUpperCase() ?? "loading city..",
                  style: GoogleFonts.oswald(
                      fontSize: 30,
                      color:
                          (bgcolor(getWeatherinfo(_weather?.mainCondition)) ==
                                  Colors.white)
                              ? Colors.black
                              : Colors.white),
                ),
                Spacer(),
                Lottie.asset(getWeatherinfo(_weather?.mainCondition)),
                Spacer(),
                Text(
                  '${_weather?.temprature.round()}°',
                  style: GoogleFonts.oswald(
                      fontSize: 60,
                      color:
                          (bgcolor(getWeatherinfo(_weather?.mainCondition)) ==
                                  Colors.white)
                              ? Colors.black
                              : Colors.white),
                ),
              ],
            ),
          ),
        ));
  }
}
