class CarAccessories {
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
  final String featured_image;

  const CarAccessories({
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
    required this.featured_image,
  });

  factory CarAccessories.fromMap(Map<String, dynamic> map) {
    return CarAccessories(
      id: map['id'],
      date: map['date'],
      slug: map['slug'],
      status: map['status'],
      link: map['link'],
      title: map['title']['rendered'],
      content: map['content']['rendered'],
      featuredMedia: map['featured_media'],
      phone: map['acf']['phone'],
      whatsapp: map['acf']['whatsapp'],
      address: map['acf']['address'],
      mapLocation: map['acf']['map_loction'],
      featured_image:map['featured_image'] ?? '',
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
      'featured_image':featured_image,
    };
  }
}
