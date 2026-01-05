import 'package:domain/models/music_models/stream_enum.dart';

class SoundCloudStreamTypeMapper {
  static StreamTypeEnum? fromKey(String key) {
    switch (key) {
      case 'http_mp3_128_url':
        return StreamTypeEnum.httpMp3128;
      case 'hls_aac_160_url':
        return StreamTypeEnum.hlsAac160;
      case 'hls_mp3_128_url':
        return StreamTypeEnum.hlsMp3128;
      case 'hls_opus_64_url':
        return StreamTypeEnum.hlsOpus64;
      case 'preview_mp3_128_url':
        return StreamTypeEnum.previewMp3128;
      default:
        return null;
    }
  }
}
