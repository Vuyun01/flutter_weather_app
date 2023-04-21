import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/helper/api/api_constants.dart';
import 'package:weather_app/screens/map_screen.dart';
import 'package:weather_app/screens/search_screen.dart';
import '../helper/api/api_helper.dart';
import '../models/weather.dart';
import '../widgets/current_weather_hours.dart';
import '../widgets/current_weather_item_grid.dart';
import '../widgets/weather_days.dart';
import '../widgets/weather_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.location});
  final LocationData? location;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _location;
  // late Future<Weather?> _weather;
  Future<Weather?> fetchData(double? latitude, double? longitude) {
    final targetLat = latitude ?? currentLat;
    final targetLong = longitude ?? currentLong;
    return APIHelper.fetchWeatherDataFromServer(targetLat, targetLong);
  }

// @override
//   void didChangeDependencies() {
  // final lat = _location?.latitude ?? widget.location?.latitude;
  // final lon = _location?.longitude ?? widget.location?.longitude;
//     _weather = fetchData(lat, lon);
//     super.didChangeDependencies();
//   }
  @override
  Widget build(BuildContext context) {
    final lat = _location?.latitude ?? widget.location?.latitude;
    final lon = _location?.longitude ?? widget.location?.longitude;
    print('rebuild');
    return Scaffold(
      body: FutureBuilder(
          future: fetchData(lat, lon),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.secondary),
              );
            }
            final weatherType = snapshot.data?.mainInfo.main ?? clouds;
            final time = snapshot.data?.details.dt ?? DateTime.now();
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(getWeatherBg(weatherType,
                          time)), //get weather background based on its name & current hour
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      WeatherHeader(
                        weather: snapshot.data,
                      ),
                      const CurrentWeatherEachHours(),
                      const WeatherEachDays(),
                      CurrentWeatherItemGrid(
                        weather: snapshot.data,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
            color: cardBgColor,
            border: Border(
                top:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () async {
                  _location = await Navigator.of(context)
                      .pushNamed(MapScreen.routeName, arguments: {
                    'lat': _location?.latitude ?? widget.location?.latitude,
                    'lon': _location?.longitude ?? widget.location?.longitude
                  }).then((value) {
                    if (value == null) return _location;
                    return value as LatLng;
                  });
                  setState(() {
                    print(_location?.latitude);
                  });
                },
                icon: const Icon(Icons.map)),
            IconButton(
                onPressed: () async {
                  await APIHelper.loadingCurrentLocation().then((value) {
                    final json = [value?.latitude, value?.longitude];
                    _location = LatLng.fromJson(json) ??
                        _location; //reasign to a new LatLng object
                  });
                  setState(() {
                    print('updated');
                  });
                },
                icon: const Icon(Icons.near_me)),
            IconButton(
                onPressed: () async {
                  _location = await Navigator.of(context)
                      .pushNamed(SearchLocationScreen.routeName)
                      .then((value) {
                    if (value == null) return _location;
                    return value as LatLng;
                  });
                  setState(() {
                    print('update location from Search screen');
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    );
  }
}
