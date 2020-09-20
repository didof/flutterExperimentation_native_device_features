import 'package:flutter/material.dart';
import 'package:native_device_features/logic/models/model-place.dart';

class ProviderGreatPlaces with ChangeNotifier {
  List<ModelPlace> _items = [];

  List<ModelPlace> get items {
    return [..._items];
  }
}
