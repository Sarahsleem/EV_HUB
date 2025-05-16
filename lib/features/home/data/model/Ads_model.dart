class AdsModel {
  final int id;
  final String date;
  final String modified;
  final String slug;
  final String status;
  final String type;
  final String link;
  final String title;
  final String content;
  final int featuredMedia;
  final String template;
  final Map<String, dynamic> meta;
  final List<String> classList;
  final List<dynamic> acf;
  final String featuredImage;
  final dynamic links;

  AdsModel({
    required this.id,
    required this.date,
    required this.modified,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.featuredMedia,
    required this.template,
    required this.meta,
    required this.classList,
    required this.acf,
    required this.featuredImage,
    required this.links,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      modified: json['modified'] ?? '',
      slug: json['slug'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      link: json['link'] ?? '',
      title: json['title']?['rendered'] ?? '',
      content: json['content']?['rendered'] ?? '',
      featuredMedia: json['featured_media'] ?? 0,
      template: json['template'] ?? '',
      meta: json['meta'] ?? {},
      classList: List<String>.from(json['class_list'] ?? []),
      acf: json['acf'] ?? [],
      featuredImage: json['featured_image'] ?? '',
      links: json['_links'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'modified': modified,
      'slug': slug,
      'status': status,
      'type': type,
      'link': link,
      'title': {'rendered': title},
      'content': {'rendered': content},
      'featured_media': featuredMedia,
      'template': template,
      'meta': meta,
      'class_list': classList,
      'acf': acf,
      'featured_image': featuredImage,
      '_links': links,
    };
  }
}
