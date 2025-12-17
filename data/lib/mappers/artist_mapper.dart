import 'package:domain/models/music_models/artist_model.dart';

import '../entities/soundcloud/artist_entity.dart';
import '../entities/supabase/liked_artist_metadata_entity.dart';

class ArtistMapper {
  static ArtistModel toModel({
    required ArtistEntity entity,
    LikedArtistMetadataEntity? likedData,
  }) {
    return ArtistModel(
      urn: entity.urn,
      name: entity.fullName ?? entity.username,
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      location: '',
      description: entity.description,
      globalLikesCount: entity.followers,

      isLiked: likedData != null,
      userListenCount: likedData?.listenCount ?? 0,
      likedAt: likedData?.createdAt,
    );
  }

  static LikedArtistMetadataEntity toMeta(ArtistModel model, String userId) {
    return LikedArtistMetadataEntity(
      urn: model.urn,
      userId: userId,
      listenCount: model.userListenCount,
      createdAt: DateTime.now(),
    );
  }
}
