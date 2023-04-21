import 'dart:convert';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/helper/firebase/firebase_constant.dart';
import 'package:weather_app/helper/firebase/firestore_helper.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart' as loc;
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class APIHelper {
  static Future<loc.Location?> fetchLocationFromServer(
      [double lat = 21.027763, double lon = 105.834160]) async {
    final url = Uri.parse(getLocationURL(lat, lon));
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List;
        final location = loc.Location.fromMap(extractedData[0]);
        // print(location);
        return location;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<Weather?> fetchWeatherDataFromServer(
      [double lat = 21.027763, double lon = 105.834160]) async {
    final location = await fetchLocationFromServer(lat, lon);
    final prefs = await SharedPreferences.getInstance(); //get shared preference
    if (location == null) {
      prefs.clear();
      return null;
    }
    final locationId =
        '${location.lat}-${location.lon}'; //create id to store on firebase
    await FirestoreHelper.instance.addData(
        FirebaseConstant.collectionLocationName,
        locationId,
        location.toMap()); //push a location to firestore
    final url = Uri.parse(getWeatherURL(lat, lon, excludeMinutely: true));


    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        // print(extractedData['current']);
        final data = {
          FirebaseConstant.id: locationId,
          FirebaseConstant.data: extractedData
        };
        final checkData =
            await FirestoreHelper.instance.findWeatherDataById(locationId);
        if (checkData.size == 1) {
          //has data
          // print('updated');
          await FirestoreHelper.instance.updateData(
              FirebaseConstant.collectionWeatherName, locationId, data);
        } else {
          // print(data['id']);
          await FirestoreHelper.instance.addData(
              FirebaseConstant.collectionWeatherName, locationId, data);
        }
        await prefs.setString('locationId', locationId); //store the locationId
        return Weather.fromMap(
            extractedData['current'], location); //current weather
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<dynamic> fetchForecastData([bool isForecast = true]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationId = prefs.getString('locationId');
      if (locationId == null) return null;
      final extractedLocationData = await FirestoreHelper.instance
          .getData(FirebaseConstant.collectionLocationName, locationId);
      final locationData = extractedLocationData.data();
      if (locationData == null) return null;
      final extractedWeatherData =
          await FirestoreHelper.instance.findWeatherDataById(locationId);
      final mapData = extractedWeatherData.docs.single.data()['data'];
      // print(mapData.data()['data']['current']);
      // print(locationData);
      if (isForecast) {
        return Forecast.fromMap(mapData, loc.Location.fromMap(locationData));
      }
      return HourlyWeather.fromMap(mapData, loc.Location.fromMap(locationData));
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<LocationData?> loadingCurrentLocation() async {
    Location locationInstance = Location.instance;
    bool serviceEnable;
    PermissionStatus permissionStatus;
    //check location service if it was enabling or disabling
    serviceEnable = await locationInstance.serviceEnabled();
    if (!serviceEnable) {
      serviceEnable = await locationInstance.requestService();
      if (!serviceEnable) return null;
    }
    //check permission status
    permissionStatus = await locationInstance.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationInstance.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return null;
    }
    final location = await Location.instance.getLocation();
    return location;
  }

  static Future<Iterable<loc.Location?>> fetchSuggestionsByKeyword(
      String keyword) async {
    final url = Uri.parse(getSearchAutocompleteURL(keyword));
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List;
        return extractedData.map((e) => loc.Location.fromMap(e));
      }
    } catch (e) {
      print(e);
    }
    return {};
  }
}
