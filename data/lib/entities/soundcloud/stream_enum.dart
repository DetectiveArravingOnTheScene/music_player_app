enum StreamType {
  httpMp3128,
  hlsAac160,
  hlsMp3128,
  hlsOpus64,
  previewMp3128;

  static StreamType? fromKey(String key) {
    switch (key) {
      case 'http_mp3_128_url':
        return StreamType.httpMp3128;
      case 'hls_aac_160_url':
        return StreamType.hlsAac160;
      case 'hls_mp3_128_url':
        return StreamType.hlsMp3128;
      case 'hls_opus_64_url':
        return StreamType.hlsOpus64;
      case 'preview_mp3_128_url':
        return StreamType.previewMp3128;
      default:
        return null;
    }
  }
}
