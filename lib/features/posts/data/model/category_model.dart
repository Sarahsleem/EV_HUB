class CategoriesModel {
  final int id;
  final String name;
  final String slug;
  final String link;
  final int count;
  final int parent;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.link,
    required this.count,
    required this.parent,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      link: json['link'],
      count: json['count'],
      parent: json['parent'],
    );
  }
}
