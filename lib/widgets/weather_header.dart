import 'package:flutter/material.dart';
import 'package:weather_app/helper/api/api_constants.dart';
import 'package:weather_app/models/weather.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({
    Key? key,
    this.weather,
  }) : super(key: key);

  final Weather? weather;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final location = weather?.location.name ?? 'N/A';
    final weatherInfo = weather?.details;
    print('current header rebuild');
    return SizedBox(
      height: size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            location,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 35),
          ),
          SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.15,
              child: weather?.mainInfo.icon == null
                  ? null
                  : Image.network(
                      '$urlWeatherIcons${weather!.mainInfo.icon}.png',
                      fit: BoxFit.cover,
                    )),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '${weatherInfo?.temp.round()}°',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            weather?.mainInfo.main ?? 'N/A',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            weather?.mainInfo.description ?? 'N/A',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.tertiary),
          ),
        ],
      ),
    );
  }
}
