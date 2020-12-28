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

  PersonalPage findById(String id) {
    return _items.firstWhere((page) => page.id == id);
  }

  void addPage(String name, File image) {
    final newPage = PersonalPage(
      id: DateTime.now().toString(),
      name: name,
      image: image,
    );
    _items.add(newPage);
    notifyListeners();
    DBHelper.db.insert(
      "pages",
      {
        "id": newPage.id,
        "name": newPage.name,
        "image": newPage.image.path,
      },
    );
  }

  void editPage(String id, String name, File image) {
    final index = _items.indexWhere((page) => page.id == id);
    _items[index].name = name;
    _items[index].image = image;
    notifyListeners();
    DBHelper.db.update(
      table: "pages",
      columnId: "name",
      setArg: name,
      whereColumnId: "id",
      whereArg: id,
    );
    DBHelper.db.update(
      table: "pages",
      columnId: "image",
      setArg: image.path,
      whereColumnId: "id",
      whereArg: id,
    );
  }

  void deletePage(String id) {
    _items.removeWhere((page) => page.id == id);
    notifyListeners();
    DBHelper.db.delete(
      table: "pages",
      columnId: "id",
      whereArg: id,
    );
  }
}
