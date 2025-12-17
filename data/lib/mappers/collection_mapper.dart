import 'package:domain/models/music_models/collection_model.dart';

import '../entities/soundcloud/collection_entity.dart';

class CollectionMapper<Entity, Model> {
  CollectionModel<Model> toModel(
    CollectionEntity<Entity> collectionEntity,
    Model Function(Entity) mapEntityToModel,
  ) {
    return CollectionModel<Model>(
      items: collectionEntity.collection
          .map((Entity entity) => mapEntityToModel(entity))
          .toList(),
      nextHref: collectionEntity.nextHref,
    );
  }
}
