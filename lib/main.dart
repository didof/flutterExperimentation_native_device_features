import 'package:flutter/material.dart';
import 'package:native_device_features/logic/providers/provider-great_places.dart';
import 'package:native_device_features/presentetional/screens/add_place/screen-add_place.dart';
import 'package:provider/provider.dart';

import 'presentetional/screens/permissions/screen-permissions.dart';
import 'presentetional/screens/places_list/screen-places_list.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  static const app_name = 'Native Devide Features';

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.indigo,
    accentColor: Colors.amber,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderGreatPlaces()),
        ChangeNotifierProvider(create: (_) => ProviderGreatPlaces()),
      ],
      child: MaterialApp(
        title: app_name,
        theme: theme,
        initialRoute: ScreenPlacesList.routeName,
        routes: {
          ScreenPlacesList.routeName: (_) => ScreenPlacesList(),
          ScreenAddPlace.routeName: (_) => ScreenAddPlace(),
          ScreenPermissions.routeName: (_) => ScreenPermissions(),
        },
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
      ),
    );
  }
}
