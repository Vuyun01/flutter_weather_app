import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/helper/api/api_constants.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/map';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isSelected = false;
  LatLng? _selectedLocation;
  @override
  Widget build(BuildContext context) {
    final location =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final targetLat =
        _selectedLocation?.latitude ?? (location?['lat'] ?? currentLat);
    final targetLon =
        _selectedLocation?.longitude ?? (location?['lon'] ?? currentLong);
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(targetLat, targetLon), zoom: 12),
          onTap: (value) {
            _isSelected = true;
            setState(() {
              _selectedLocation = value;
            });
            print(_selectedLocation?.latitude);
          },
          markers: {
            Marker(
                markerId: const MarkerId('loc1'),
                position: LatLng(targetLat, targetLon))
          },
        ),
        Positioned(
            top: 30,
            left: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                ))),
        Positioned(
            top: 30,
            right: 10,
            child: IconButton(
                onPressed: _isSelected
                    ? () {
                        Navigator.of(context).pop(_selectedLocation);
                      }
                    : null,
                icon: Icon(
                  Icons.done,
                  color: _isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiary,
                )))
      ]),
    );
  }
}
