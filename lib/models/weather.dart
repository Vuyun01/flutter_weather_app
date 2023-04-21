// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:weather_app/models/location.dart';

class Details {
  final DateTime dt;
  final DateTime? sunrise;
  final DateTime? sunset;
  final dynamic temp;
  final dynamic feels_like;
  final int pressure;
  final int humidity;
  final dynamic dew_point;
  final dynamic uvi;
  final int clouds;
  final int? visibility;
  final dynamic wind_speed;
  Details({
    required this.dt,
    this.sunrise,
    this.sunset,
    required this.temp,
    required this.feels_like,
    required this.pressure,
    required this.humidity,
    required this.dew_point,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.wind_speed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt.millisecondsSinceEpoch,
      'sunrise': sunrise?.millisecondsSinceEpoch,
      'sunset': sunset?.millisecondsSinceEpoch,
      'temp': temp,
      'feels_like': feels_like,
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dew_point,
      'uvi': uvi,
      'clouds': clouds,
      'visibility': visibility,
      'wind_speed': wind_speed,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      dt: DateTime.fromMillisecondsSinceEpoch((map['dt'] as int) * 1000),
      sunrise: map['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['sunrise'] as int) * 1000)
          : null,
      sunset: map['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['sunset'] as int) * 1000)
          : null,
      temp: map['temp'],
      feels_like: map['feels_like'],
      pressure: map['pressure'],
      humidity: map['humidity'],
      dew_point: map['dew_point'],
      uvi: map['uvi'],
      clouds: map['clouds'],
      visibility: map['visibility'] ?? 10000,
      wind_speed: map['wind_speed'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory Details.fromJson(String source) =>
  //     Details.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Details(dt: $dt, sunrise: $sunrise, sunset: $sunset, temp: $temp, feels_like: $feels_like, pressure: $pressure, humidity: $humidity, dew_point: $dew_point, uvi: $uvi, clouds: $clouds, visibility: $visibility, wind_speed: $wind_speed)';
  }
}

class MainInfo {
  final int id;
  final String main;
  final String description;
  final String icon;
  MainInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory MainInfo.fromMap(Map<String, dynamic> map) {
    return MainInfo(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory MainInfo.fromJson(String source) =>
  //     MainInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MainInfo(id: $id, main: $main, description: $description, icon: $icon)';
  }
}

class Weather {
  final Location location;
  final Details details;
  final MainInfo mainInfo;
  Weather({
    required this.location,
    required this.details,
    required this.mainInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'details': details.toMap(),
      'mainInfo': mainInfo.toMap(),
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map, Location location) {
    return Weather(
      location: location,
      details: Details.fromMap(map),
      mainInfo: MainInfo.fromMap(map['weather'][0] as Map<String, dynamic>),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Weather.fromJson(Map<String, dynamic> json) {
  //   return Weather(
  //       location: Location.fromMap(json['location']),
  //       details: Details.fromMap(json['details']),
  //       mainInfo: MainInfo.fromMap(json['mainInfo']));
  // }

  @override
  String toString() =>
      'Weather(location: $location, details: $details, mainInfo: $mainInfo)';
}

class HourlyWeather {
  final Location location;
  final List<Weather> weathers;
  HourlyWeather({
    required this.location,
    required this.weathers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'weathers': weathers.map((x) => x.toMap()).toList(),
    };
  }

  factory HourlyWeather.fromMap(Map<String, dynamic> map, Location location) {
    return HourlyWeather(
        location: location,
        weathers: (map['hourly'] as List)
            .map((e) => Weather.fromMap(e, location))
            .toList());
  }

  // String toJson() => json.encode(toMap());

  // factory HourlyWeather.fromJson(String source) {
  //   final extractedData = json.decode(source) as Map<String, dynamic>;
  //   final location =
  //       Location.fromMap(extractedData['location'] as Map<String, dynamic>);
  //   return HourlyWeather(
  //       location: location,
  //       weathers: (extractedData['weathers'] as List)
  //           .map((e) => Weather.fromJson(e))
  //           .toList());
  // }

  @override
  String toString() =>
      'HourlyWeather(location: $location, weathers: $weathers)';
}
