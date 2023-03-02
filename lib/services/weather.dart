import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

class WeatherModel {
  Future<dynamic> getCityName(String cityname) async {
    var cityurl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=7d43c34b896a9b8b4418bed6860f1b8d&units=metric';
    NetworkHelper networkHelper = NetworkHelper(cityurl);
    var weatherdatacity = await networkHelper.getData();
    return weatherdatacity;
  }

  Future<dynamic> getLocationweather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitute}&lon=${location.longitude}&appid=7d43c34b896a9b8b4418bed6860f1b8d&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
