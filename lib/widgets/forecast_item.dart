import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helper/api/api_constants.dart';
import '../models/weather.dart';

class ForecastItem extends StatelessWidget {
  const ForecastItem({
    super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final date = weather.details.dt;
    final max_temp = (weather.details.temp[t_max]).round();
    final min_temp = (weather.details.temp[t_min]).round();
    // print(weather.mainInfo.icon);
    print('forecast item rebuild');
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    date.day == DateTime.now().day
                        ? 'Today'
                        : DateFormat.E().format(date),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Image.network(
                  '$urlWeatherIcons${weather.mainInfo.icon}.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                SizedBox(
                    // color: Colors.cyan,
                    width: size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$min_temp°',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                        ),
                        Container(
                          height: 3,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Text(
                          '$max_temp°',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ))
              ],
            ),
            Divider(
              height: 0,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
