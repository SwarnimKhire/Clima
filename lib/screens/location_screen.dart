import 'dart:convert';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int ?temp1;
  String? wIcon;
  String ?cityname;
  String ?wmessage;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        temp1 = 0;
        wIcon = 'Error';
        wmessage = 'Unable to fetch weather data.';
        cityname = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temp1 = temp.toInt();

      var condt = weatherData['weather'][0]['id'];

      wIcon = weatherModel.getWeatherIcon(condt);
      wmessage = weatherModel.getMessage(temp1!);
      cityname = weatherData['name'];

      print(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weathernew = await weatherModel.getLocationweather();
                      updateUI(weathernew);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return CityScreen();
                      })));
                      if (typedname != null) {
                        var weatherdata =
                            await weatherModel.getCityName(typedname);
                        updateUI(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp1*',
                      style: kTempTextStyle,
                    ),
                    Text(
                      wIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$wmessage in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
