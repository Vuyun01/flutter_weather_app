import 'package:flutter/material.dart';

const cardBgColor = Colors.transparent;
const appBarBgColor = Color.fromARGB(255, 13, 12, 12);
const backgroundColor = Color.fromARGB(255, 23, 22, 22);
const bgColorInputField = Color.fromARGB(255, 207, 204, 204);
const iconColor = Color.fromARGB(255, 30, 182, 167);
const borderInputFieldColor = Color.fromARGB(255, 47, 206, 190);

//images
const drizzle = 'assets/images/drizzle.jpg';
const clear = 'assets/images/clear.jpg';
const clouds = 'assets/images/clouds.jpg';
const mist = 'assets/images/mist.jpg';
const night = 'assets/images/night.jpg';
const rain = 'assets/images/rain.jpg';
const snow = 'assets/images/snow.jpg';
const sun = 'assets/images/sun.jpg';
const thunderstorm = 'assets/images/thunderstorm.jpg';

String getWeatherBg(String name, DateTime time) {
  if (name == 'Clouds') {
    return clouds;
  } else if (name == 'Rain') {
    return rain;
  } else if (name == 'Drizzle') {
    return drizzle;
  } else if (name == 'Snow') {
    return snow;
  } else if (name == 'Thunderstorm') {
    return thunderstorm;
  } else if (name == 'Mist') {
    return mist;
  } else if (name == 'Clear') {
    if (time.hour >= 5 && time.hour < 12) {
      return sun;
    } else if (time.hour >= 12 && time.hour < 19) {
      return clear;
    } else if (time.hour >= 19) {
      return night;
    }
  }
  return clouds;
}
