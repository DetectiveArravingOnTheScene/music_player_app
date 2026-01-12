class CollectionModel<T> {
  final List<T> items;
  String? nextHref;

  CollectionModel({required this.items, this.nextHref});

  static const Object _sentinel = Object();

  CollectionModel<T> copyWith({
    List<T>? items,
    Object? nextHref = _sentinel,
  }) {
    return CollectionModel<T>(
      items: items ?? this.items,
      nextHref: nextHref == _sentinel ? this.nextHref : nextHref as String?,
    );
  }
}
