// ignore: library_prefixes
import 'package:domain/models/music_models/stream_type.dart' as ModelStreamType;

import '../entities/soundcloud/stream_enum.dart';

class StreamTypeMapper {
  static Map<ModelStreamType.StreamType, String> mapToModel(
    Map<StreamType, String> entityMap,
  ) {
    final Map<ModelStreamType.StreamType, String> modelMap =
        <ModelStreamType.StreamType, String>{};

    entityMap.forEach((StreamType key, String value) {
      final ModelStreamType.StreamType modelKey = _mapEnumToModel(key);
      modelMap[modelKey] = value;
    });

    return modelMap;
  }

  static ModelStreamType.StreamType _mapEnumToModel(StreamType streamType) {
    switch (streamType) {
      case StreamType.httpMp3128:
        return ModelStreamType.StreamType.httpMp3128;
      case StreamType.hlsAac160:
        return ModelStreamType.StreamType.hlsAac160;
      case StreamType.hlsMp3128:
        return ModelStreamType.StreamType.hlsMp3128;
      case StreamType.hlsOpus64:
        return ModelStreamType.StreamType.hlsOpus64;
      case StreamType.previewMp3128:
        return ModelStreamType.StreamType.previewMp3128;
    }
  }
}
