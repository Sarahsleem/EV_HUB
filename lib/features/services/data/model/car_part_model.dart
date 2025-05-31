class CarParts {
  final int id;
  final String date;
  final String slug;
  final String status;
  final String link;
  final String title;
  final String content;
  final int featuredMedia;
  final String phone;
  final String whatsapp;
  final String address;
  final String mapLocation;
  final String featuredImage; // ✅ New field

  const CarParts({
    required this.id,
    required this.date,
    required this.slug,
    required this.status,
    required this.link,
    required this.title,
    required this.content,
    required this.featuredMedia,
    required this.phone,
    required this.whatsapp,
    required this.address,
    required this.mapLocation,
    required this.featuredImage, // ✅ New field
  });

  factory CarParts.fromMap(Map<String, dynamic> map) {
    return CarParts(
      id: map['id'] ?? 0,
      date: map['date'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      link: map['link'] ?? '',
      title: map['title']?['rendered'] ?? '',
      content: map['content']?['rendered'] ?? '',
      featuredMedia: map['featured_media'] ?? 0,
      phone: map['acf']?['phone'] ?? '',
      whatsapp: map['acf']?['whatsapp'] ?? '',
      address: map['acf']?['address'] ?? '',
      mapLocation: map['acf']?['map_loction'] ?? '',
      featuredImage: map['featured_image'] ?? '', // ✅ Extract featured_image
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'slug': slug,
      'status': status,
      'link': link,
      'title': title,
      'content': content,
      'featuredMedia': featuredMedia,
      'phone': phone,
      'whatsapp': whatsapp,
      'address': address,
      'mapLocation': mapLocation,
      'featured_image': featuredImage, // ✅ include in toMap
    };
  }

  @override
  String toString() {
    return 'CarParts{id: $id, date: $date, slug: $slug, status: $status, link: $link, title: $title, content: $content, featuredMedia: $featuredMedia, phone: $phone, whatsapp: $whatsapp, address: $address, mapLocation: $mapLocation, featuredImage: $featuredImage}';
  }
}
