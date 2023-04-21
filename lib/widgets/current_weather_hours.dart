import 'package:flutter/material.dart';
import 'package:weather_app/helper/api/api_helper.dart';
import 'package:weather_app/models/weather.dart';

import '../constant.dart';
import '../helper/api/api_constants.dart';

class CurrentWeatherEachHours extends StatefulWidget {
  const CurrentWeatherEachHours({
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentWeatherEachHours> createState() =>
      _CurrentWeatherEachHoursState();
}

class _CurrentWeatherEachHoursState extends State<CurrentWeatherEachHours> {
  late Future _hourly;

  @override
  void initState() {
    _hourly = APIHelper.fetchForecastData(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('current hourly rebuild');
    return Card(
      // margin: EdgeInsets.only(),
      color: cardBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: size.height * 0.25,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('The weather in the coming hours'),
            ),
            Divider(
              color: Theme.of(context).colorScheme.tertiary,
              indent: 20,
              endIndent: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: _hourly,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  }
                  final data = snapshot.data;
                  // print('Forecast:  --->  $data');
                  return data == null
                      ? const Center(
                          child: Text('No Data'),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.weathers.length ~/ 2,
                          itemBuilder: ((context, index) {
                            final weather_details =
                                data.weathers[index].details;
                            final weather_main_info =
                                data.weathers[index].mainInfo;
                            bool isCurrent =
                                weather_details.dt.hour == DateTime.now().hour;
                            return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      isCurrent
                                          ? 'Now'
                                          : '${weather_details.dt.hour}',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Image.network(
                                        '$urlWeatherIcons${weather_main_info.icon}.png'),
                                    Text('${weather_details.temp.round()}°',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ));
                          }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
