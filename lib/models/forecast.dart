// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weather_app/models/weather.dart';
import 'location.dart';

class Forecast {
  final Location location;
  final List<Weather> forecasts;
  Forecast({
    required this.location,
    required this.forecasts,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'forecasts': forecasts.map((x) => x.toMap()).toList(),
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map, Location location) {
    return Forecast(
        location: location,
        forecasts: (map['daily'] as List)
            .map((e) => Weather.fromMap(e, location))
            .toList());
  }

  // String toJson() => json.encode(toMap());

  // factory Forecast.fromJson(String source) {
  //   final extractedData = json.decode(source) as Map<String, dynamic>;
  //   final location =
  //       Location.fromMap(extractedData['location'] as Map<String, dynamic>);
  //   return Forecast(
  //       forecasts: (extractedData['forecasts'] as List)
  //           .map((e) => Weather.fromMap(e, location))
  //           .toList(),
  //       location: location);
  // }

  // @override
  // String toString() => 'Forecast(location: $location, forecasts: $forecasts)';
}
