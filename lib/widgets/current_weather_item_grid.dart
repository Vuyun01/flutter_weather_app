import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';
import 'current_weather_item.dart';

class CurrentWeatherItemGrid extends StatelessWidget {
  const CurrentWeatherItemGrid({
    Key? key,
    this.weather,
  }) : super(key: key);

  final Weather? weather;
  @override
  Widget build(BuildContext context) {
    final weatherInfo = weather?.details;
    print('current grid rebuild');
    return weatherInfo != null
        ? GridView.custom(
            padding: const EdgeInsets.only(top: 5),
            physics:
                const NeverScrollableScrollPhysics(), //prevent default scrolling behavior
            shrinkWrap: true, //allow to shrink based on its children
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            childrenDelegate: SliverChildListDelegate([
              CurrentWeatherItem(
                icon: Icons.sunny,
                title: 'UV INDEX',
                specification: '${weatherInfo.uvi.round()}',
                description: 'Low for the rest of day',
              ),
              CurrentWeatherItem(
                icon: CupertinoIcons.sunset,
                title: 'SUNSET',
                specification: DateFormat.Hm().format(weatherInfo.sunset!),
                description:
                    'Sunrise at ${DateFormat.Hm().format(weatherInfo.sunrise!)}',
              ),
              CurrentWeatherItem(
                icon: CupertinoIcons.wind,
                title: 'WIND',
                specification: '${weatherInfo.wind_speed.round()} m/s',
                description: 'Maximum wind speed might reach ${((weatherInfo.wind_speed * 3600)/1000).round()} km/h',
              ),
              CurrentWeatherItem(
                icon: Icons.thermostat,
                title: 'FEELS LIKE',
                specification: '${weatherInfo.feels_like.round()}°',
                description: 'Humidity is making it feel warmer',
              ),
              CurrentWeatherItem(
                icon: CupertinoIcons.cloud_fog_fill,
                title: 'HUMIDITY',
                specification: '${weatherInfo.humidity}%',
                description: 'The dew point is ${weatherInfo.dew_point.round()}° right now',
              ),
              CurrentWeatherItem(
                icon: Icons.remove_red_eye_rounded,
                title: 'VISIBILITY',
                specification: '${(weatherInfo.visibility! ~/ 1000)} km',
                description: 'It\'s clear right now',
              ),
              CurrentWeatherItem(
                icon: CupertinoIcons.stopwatch_fill,
                title: 'PRESSURE',
                specification: '${weatherInfo.pressure} hPa',
              ),
              CurrentWeatherItem(
                icon: CupertinoIcons.cloud_fill,
                title: 'CLOUDS',
                specification: '${weatherInfo.clouds}%',
              ),
            ]))
        : Container();
  }
}
