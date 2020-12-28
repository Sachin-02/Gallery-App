import 'dart:io';
import 'package:flutter/foundation.dart';

class PersonalPage {
  final String id;
  String name;
  File image;

  PersonalPage({
    @required this.id,
    @required this.name,
    @required this.image,
  });
}
