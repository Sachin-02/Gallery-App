import 'dart:io';
import 'package:flutter/foundation.dart';

class PersonalImage {
  final String id;
  String pageId;
  File image;
  PersonalImage({
    @required this.id,
    @required this.pageId,
    @required this.image,
  });
}
