import 'dart:io';
import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/personal_image.dart';

class PersonalImages with ChangeNotifier {
  List<PersonalImage> _items = [];

  List<PersonalImage> get items {
    return [..._items];
  }

  Future<void> fetchAndSetImages(String pageId) async {
    final data = await DBHelper.db.getData(
      table: "images",
      columnId: "pageId",
      arg: pageId,
    );
    _items = data
        .map((personalImage) => PersonalImage(
              id: personalImage["id"],
              pageId: personalImage["pageId"],
              image: File(personalImage["image"]),
            ))
        .toList();
    notifyListeners();
  }

  void addImage(String pageId, File image) {
    final newImage = PersonalImage(
      id: DateTime.now().toString(),
      pageId: pageId,
      image: image,
    );
    _items.add(newImage);
    notifyListeners();
    DBHelper.db.insert(
      "images",
      {
        "id": newImage.id,
        "pageId": newImage.pageId,
        "image": newImage.image.path,
      },
    );
  }
}
