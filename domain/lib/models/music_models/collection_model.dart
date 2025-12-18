class CollectionModel<T> {
  final List<T> items;
  String? nextHref;

  CollectionModel({required this.items, this.nextHref});
}
