import 'dart:io';

import 'package:flutter/material.dart';

class ProviderAddPlace with ChangeNotifier {
  bool _showFAB = false;
  List<File> _images = [];

  bool get showFAB {
    return _showFAB ? true : false;
  }

  bool get thereAreNotImages {
    return _images.length > 0 ? false : true;
  }

  List<File> get images {
    return _images;
  }

  void injectImage(File providedImage) {
    _images.add(providedImage);
    notifyListeners();
  }

  void removeImage(String path) {
    _images.removeWhere((i) {
      return i.path == path;
    });
    notifyListeners();
  }

  Function validators(String label) {
    List validators = [
      {
        'title': (String value) {
          if (value.isEmpty) return 'must not be empty';
          if (value.length <= 5) return 'too short - minimum 5 characters';
          if (value.length >= 20) return 'too long - maximum 20 characters';
          return null;
        },
      }
    ];

    return validators.firstWhere((el) => el.keys.first == label).values.first;
  }

  dynamic validatorTitle(String value) {
    if (value.isEmpty) return 'Please, select a title';
    return null;
  }
}
