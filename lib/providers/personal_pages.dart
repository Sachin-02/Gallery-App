import 'dart:io';
import 'package:flutter/material.dart';
import '../models/personal_page.dart';

class PersonalPages with ChangeNotifier {
  List<PersonalPage> _items = [];

  List<PersonalPage> get items {
    return [..._items];
  }

  void addPage(String name, File image) {
    final newPage = PersonalPage(
      id: DateTime.now().toString(),
      name: name,
      image: image,
    );
    _items.add(newPage);
    notifyListeners();
  }
}
