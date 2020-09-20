import 'package:flutter/material.dart';
import 'package:native_device_features/logic/providers/provider-add_place.dart';
import 'package:native_device_features/presentetional/layouting_helpers/custom_app_bar.dart';
import 'package:native_device_features/presentetional/layouting_helpers/responsive_safe_area.dart';
import 'package:native_device_features/presentetional/screens/add_place/body-add_place.dart';
import 'package:provider/provider.dart';

class ScreenAddPlace extends StatelessWidget {
  static const routeName = '/add_place';
  static const screenName = 'Add a new Place';
  const ScreenAddPlace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderAddPlace(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: screenName,
        ),
        body: ResponsiveSafeArea(
          builder: (context, size) {
            return BodyAddPlace();
          },
        ),
        floatingActionButton: _CustomFloatinActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class _CustomFloatinActionButton extends StatelessWidget {
  const _CustomFloatinActionButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showFAB = Provider.of<ProviderAddPlace>(context).showFAB;
    if (showFAB)
      return FloatingActionButton(
        onPressed: null,
        elevation: 5,
        tooltip: 'add new place',
        child: Icon(Icons.add),
      );
    else
      return Container(
        width: 0.0,
        height: 0.0,
      );
  }
}
