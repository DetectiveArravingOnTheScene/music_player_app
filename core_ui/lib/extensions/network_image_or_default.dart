import 'package:flutter/material.dart';

Image networkImageOrDefault(
  String? url, {
  BoxFit? fit,
  bool highQuality = false,
}) {
  if (url == null || url.isEmpty) {
    return Image.asset('assets/images/default_cover.jpg', fit: fit);
  }
  try {
    String _url = url;
    if (highQuality) {
      _url = url.replaceFirst('large', 't500x500');
    }
    return Image.network(_url, fit: fit);
  } catch (_) {
    return Image.asset('assets/images/default_cover.jpg', fit: fit);
  }
}
