import 'dart:io';
import 'package:flutter/foundation.dart';

class PersonalPage {
  final String id;
  final String name;
  final File image;

  PersonalPage({
    @required this.id,
    @required this.name,
    @required this.image,
  });
}
