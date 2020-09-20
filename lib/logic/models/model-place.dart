import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_device_features/logic/classes/place_location.dart';

class ModelPlace {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  ModelPlace({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
