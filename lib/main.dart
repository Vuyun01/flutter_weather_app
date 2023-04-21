import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/helper/api/api_helper.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/map_screen.dart';
import 'package:weather_app/screens/search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //init firebase to use all firebase's products
  final location = await APIHelper.loadingCurrentLocation();
  runApp(MyApp(location: location));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.location});
  final LocationData? location;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              backgroundColor: appBarBgColor,
              centerTitle: true),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              prefixIconColor: iconColor,
              // border: customOutlineInputBorder(),
              focusedBorder: customOutlineInputBorder(
                  width: 2, color: borderInputFieldColor),
              enabledBorder:
                  customOutlineInputBorder(color: borderInputFieldColor)),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            bodyMedium: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
            bodySmall: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white),
            headlineLarge: TextStyle(
                fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white),
            headlineMedium: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
            headlineSmall: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(foregroundColor: Colors.white)),
          colorScheme: const ColorScheme.light(
              primary: Colors.black87,
              secondary: Colors.white,
              tertiary: Color.fromARGB(255, 203, 200, 200))),
      home: HomeScreen(location: location),
      routes: {
        MapScreen.routeName: (context) => const MapScreen(),
        SearchLocationScreen.routeName: (context) =>
            const SearchLocationScreen()
      },
    );
  }

  OutlineInputBorder customOutlineInputBorder(
      {double width = 1, Color color = Colors.black}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: width, color: color));
  }
}
