import 'package:bloc/bloc.dart';
import 'package:domain/models/music_models/collection_model.dart';

mixin PaginationBlocMixin<E, S> on Bloc<E, S> {
  bool _isLoadingMore = false;

  Future<void> onPaginate<T>({
    required Emitter<S> emit,
    required CollectionModel<T>? currentCollection,
    required Future<CollectionModel<T>> Function(String nextHref) fetchNextPage,
    required S Function(CollectionModel<T> updatedCollection) onSuccess,
    void Function(Object error)? onFailure,
  }) async {
    if (_isLoadingMore) return;
    if (currentCollection == null || currentCollection.nextHref == null) return;

    _isLoadingMore = true;

    try {
      final CollectionModel<T> newPage = await fetchNextPage(
        currentCollection.nextHref!,
      );

      final List<T> mergedItems = <T>[
        ...currentCollection.items,
        ...newPage.items,
      ];

      final CollectionModel<T> updatedCollection = currentCollection.copyWith(
        items: mergedItems,
        nextHref: newPage.nextHref,
      );

      emit(onSuccess(updatedCollection));
    } catch (e) {
      onFailure?.call(e);
    } finally {
      _isLoadingMore = false;
    }
  }
}
