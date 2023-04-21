import 'package:flutter/material.dart';
import 'package:weather_app/helper/api/api_helper.dart';

import '../constant.dart';
import '../models/forecast.dart';
import 'forecast_item.dart';

class WeatherEachDays extends StatefulWidget {
  const WeatherEachDays({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherEachDays> createState() => _WeatherEachDaysState();
}

class _WeatherEachDaysState extends State<WeatherEachDays> {
  late Future _forecast;
  @override
  void initState() {
    _forecast = APIHelper.fetchForecastData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('forecast rebuild');
    return Card(
      color: cardBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 15,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '8 DAYS FORECAST',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            FutureBuilder(
              future: _forecast,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: size.height * 0.2,
                    child: Center(
                        child: CircularProgressIndicator.adaptive(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    )),
                  );
                }
                final data = snapshot.data;
                // print('Hourly:  --->  $data');
                return data == null
                    ? SizedBox(
                        height: size.height * 0.2,
                        child: const Center(child: Text('No Data')),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        itemBuilder: (context, index) => ForecastItem(
                              weather: snapshot.data!.forecasts[index],
                            ));
              },
            )
          ],
        ),
      ),
    );
  }
}
