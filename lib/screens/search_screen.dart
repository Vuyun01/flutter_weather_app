import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/helper/api/api_helper.dart';
import 'package:weather_app/models/location.dart';

class SearchLocationScreen extends StatefulWidget {
  static const String routeName = '/search';
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Search a location'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: TypeAheadField<Location?>(
              debounceDuration: const Duration(milliseconds: 500),
              textFieldConfiguration: TextFieldConfiguration(
                  style: Theme.of(context).textTheme.bodyMedium,
                  cursorColor: iconColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  )),
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                   borderRadius: BorderRadius.circular(10)
                  ),
              suggestionsCallback: (keyword) async {
                return APIHelper.fetchSuggestionsByKeyword(keyword);
              },
              itemBuilder: (context, suggestion) => ListTile(
                    title: suggestion!.region!.isEmpty
                        ? Text(
                            '${suggestion.name}, ${suggestion.country}')
                        : Text('${suggestion.name}, ${suggestion.region}, ${suggestion.country}'),
                  ),
              noItemsFoundBuilder: (context) => SizedBox(
                    height: 80,
                    child: Center(
                        child: Text(
                      'No location found!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    )),
                  ),
              loadingBuilder: (context) => const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.teal,)),
                  ),
              onSuggestionSelected: (suggestion) {
                final json = [suggestion?.lat, suggestion?.lon];
                final newLatLng = LatLng.fromJson(json);
                Navigator.of(context).pop(newLatLng);
              }),
        ),
      ),
    );
  }
}
