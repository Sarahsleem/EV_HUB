class Brand {
  final int id;
  final int count;
  final String description;
  final String link;
  final String name;
  final String slug;
  final String taxonomy;
  final int parent;
  final dynamic meta;
  final Acf acf;

  Brand({
    required this.id,
    required this.count,
    required this.description,
    required this.link,
    required this.name,
    required this.slug,
    required this.taxonomy,
    required this.parent,
    required this.meta,
    required this.acf,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] ?? 0,
      count: json['count'] ?? 0,
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      taxonomy: json['taxonomy'] ?? '',
      parent: json['parent'] ?? 0,
      meta: json['meta'] ?? {},
      acf: Acf.fromJson(json['acf'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
      'description': description,
      'link': link,
      'name': name,
      'slug': slug,
      'taxonomy': taxonomy,
      'parent': parent,
      'meta': meta,
      'acf': acf.toJson(),
    };
  }

  Brand copyWith({
    int? id,
    int? count,
    String? description,
    String? link,
    String? name,
    String? slug,
    String? taxonomy,
    int? parent,
    dynamic meta,
    Acf? acf,
  }) {
    return Brand(
      id: id ?? this.id,
      count: count ?? this.count,
      description: description ?? this.description,
      link: link ?? this.link,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      taxonomy: taxonomy ?? this.taxonomy,
      parent: parent ?? this.parent,
      meta: meta ?? this.meta,
      acf: acf ?? this.acf,
    );
  }
}

class Acf {
  final bool carModel;
  final BrandLogo brandLogo;

  Acf({
    required this.carModel,
    required this.brandLogo,
  });

  factory Acf.fromJson(Map<String, dynamic> json) {
    return Acf(
      carModel: json['car_model'] == true, // تأكد أنه قيمة منطقية
      brandLogo: BrandLogo.fromJson(json['brand_logo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'car_model': carModel,
      'brand_logo': brandLogo.toJson(),
    };
  }
}

class BrandLogo {
  final String url;
  final int width;
  final int height;

  BrandLogo({
    required this.url,
    required this.width,
    required this.height,
  });

  factory BrandLogo.fromJson(Map<String, dynamic> json) {
    return BrandLogo(
      url: json['url'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }
}