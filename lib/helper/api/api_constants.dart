
//api key
const String apiKey = '8ceb363a67bbba2ff80e6c28e7271498';
const String googleAPiKey = 'AIzaSyBpbh5WnwF-scwZagewjeMOImY2uZVAyi4';
const String apiSearchAutoKey = 'f8952941c39f4ecbb7630036232104';

//others
const String urlWeatherIcons = 'https://openweathermap.org/img/wn/';
const double currentLat = 21.027763;
const double currentLong = 105.834160;

//temp & feels_like constants
const String day = 'day';
const String night = 'night';
const String evening = 'eve';
const String moring = 'morn';
const String t_min = 'min';
const String t_max = 'max';

//urls
String getWeatherURL(
  double lat,
  double lon, {
  bool excludeHourly = false,
  bool excludeMinutely = false,
  bool excludeDaily = false,
  bool excludeCurrent = false,
}) {
  String minutely = excludeMinutely ? 'minutely' : '';
  String hourly = excludeHourly ? 'hourly' : '';
  String daily = excludeDaily ? 'daily' : '';
  String current = excludeCurrent ? 'current' : '';

  return 'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=$minutely,$hourly,$daily,$current&appid=$apiKey&units=metric';
}

String getLocationURL([double lat = 21.027763, double lon = 105.834160]) {
  return 'http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$apiKey';
}

String getSearchAutocompleteURL([String query = 'Hanoi']){
  return 'http://api.weatherapi.com/v1/search.json?key=$apiSearchAutoKey&q=$query';
}
