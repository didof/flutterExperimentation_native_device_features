import 'package:flutter/material.dart';
import 'package:native_device_features/presentetional/layouting_helpers/custom_app_bar.dart';
import 'package:native_device_features/presentetional/layouting_helpers/responsive_safe_area.dart';
import 'package:native_device_features/presentetional/screens/add_place/screen-add_place.dart';
import 'package:native_device_features/presentetional/screens/permissions/screen-permissions.dart';

import 'body-places_list.dart';

class ScreenPlacesList extends StatelessWidget {
  static const routeName = '/places_list';
  static const screenName = 'Places List';

  const ScreenPlacesList({Key key}) : super(key: key);

  List<CustomAppBarAction> _actionsBuilder(context) {
    return [
      CustomAppBarAction(
        iconData: Icons.add,
        onPressed: () {
          Navigator.of(context).pushNamed(ScreenAddPlace.routeName);
        },
      ),
      CustomAppBarAction(
        iconData: Icons.settings,
        onPressed: () {
          Navigator.of(context).pushNamed(ScreenPermissions.routeName);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: screenName,
        actions: _actionsBuilder(context),
      ),
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return BodyPlacesList();
        },
      ),
    );
  }
}
