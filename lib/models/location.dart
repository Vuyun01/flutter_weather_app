// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Location {
  final String name;
  final String country;
  final String? region;
  final double lon;
  final double lat;
  Location({
    required this.name,
    required this.country,
    this.region,
    required this.lon,
    required this.lat,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'country': country,
      'region': region,
      'lon': lon,
      'lat': lat,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String,
      country: map['country'] as String,
      region: map['region'] != null ? map['region'] as String : '',
      lon: map['lon'] as double,
      lat: map['lat'] as double,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Location.fromJson(String source) => Location.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Location(name: $name, country: $country, region: $region, lon: $lon, lat: $lat)';
  // }

}
