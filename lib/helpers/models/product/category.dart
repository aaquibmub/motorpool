class Category {
  final String id;
  final String name;
  final String parentId;
  String parentTree;

  Category(
    this.id,
    this.name,
    this.parentId,
  );
}
