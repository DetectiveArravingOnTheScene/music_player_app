import 'package:flutter/material.dart';

Image networkImageOrDefault(String? url, {BoxFit? fit}) {
  if (url == null || url.isEmpty) {
    return Image.asset('assets/images/default_cover.jpg', fit: fit);
  }
  try {
    return Image.network(url, fit: fit);
  } catch (_) {
    return Image.asset('assets/images/default_cover.jpg', fit: fit);
  }
}
