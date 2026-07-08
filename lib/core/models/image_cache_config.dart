import 'package:flutter/painting.dart';

class ImageCacheConfig {
  ImageCacheConfig._();

  static void apply() {
    PaintingBinding.instance.imageCache
      ..maximumSize       = 50   // max 50 images RAM mein
      ..maximumSizeBytes  = 30 * 1024 * 1024; // max 30 MB RAM usage
  }
}