import 'package:flutter/foundation.dart';

enum SseMethod {
  GET,
  POST,
  PATCH,
  PUT,
}

extension SseMethodEnumExtension on SseMethod {
  String get value => describeEnum(this).toUpperCase();
}
