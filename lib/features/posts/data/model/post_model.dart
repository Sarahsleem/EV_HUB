class PostModel {
  final int id;
  final String title;
  final String content;
  final String link;
  final String date;
  final String featuredImage;
  final List<CategoryModel> categories;
  final Ratings ratings;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.link,
    required this.date,
    required this.featuredImage,
    required this.categories,
    required this.ratings,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title']['rendered'] ?? '',
      content: json['content']['rendered'] ?? '',
      link: json['link'] ?? '',
      date: json['date'] ?? '',
      featuredImage: json['featured_image'] ?? '',
      categories: (json['category'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e))
          .toList() ??
          [],
      ratings: Ratings.fromJson(json['ratings'] ?? {}),
    );
  }
}
class RatingDetail {
  final String author;
  final String content;
  final double? rating;
  final String date;

  RatingDetail({
    required this.author,
    required this.content,
    required this.rating,
    required this.date,
  });

  factory RatingDetail.fromJson(Map<String, dynamic> json) {
    return RatingDetail(
      author: json['author'] ?? '',
      content: json['content'] ?? '',
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      date: json['date'] ?? '',
    );
  }
}

class Ratings {
  final double average;
  final int total;
  final List<RatingDetail> details;

  Ratings({
    required this.average,
    required this.total,
    required this.details,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      average: (json['average'] ?? 0).toDouble(),
      total: json['total'] ?? 0,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => RatingDetail.fromJson(e))
          .toList() ??
          [],
    );
  }
}
class CategoryModel {
  final int id;
  final String name;
  final String slug;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}
