import 'dart:io';
import 'package:flutter/material.dart';
import '../models/personal_page.dart';
import '../helpers/db_helper.dart';

class PersonalPages with ChangeNotifier {
  List<PersonalPage> _items = [];

  List<PersonalPage> get items {
    return [..._items];
  }

  Future<void> fetchAndSetPages() async {
    final data = await DBHelper.db.getAllData("pages");
    _items = data
        .map(
          (page) => PersonalPage(
            id: page["id"],
            name: page["name"],
            image: File(page["image"]),
          ),
        )
        .toList();
    notifyListeners();
  }

  void addPage(String name, File image) {
    final newPage = PersonalPage(
      id: DateTime.now().toString(),
      name: name,
      image: image,
    );
    _items.add(newPage);
    notifyListeners();
    DBHelper.db.insert("pages", {
      "id": newPage.id,
      "name": newPage.name,
      "image": newPage.image.path,
    });
  }
}
