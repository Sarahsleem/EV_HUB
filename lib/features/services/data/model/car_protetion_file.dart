import 'dart:convert';

class CarProtectionFilm {
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
  final String locationMap;
  final String? featuredMediaUrl; // Added to handle the featured media URL

  const CarProtectionFilm({
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
    required this.locationMap,
    this.featuredMediaUrl, // Optional field for the featured media URL
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is CarProtectionFilm &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              date == other.date &&
              slug == other.slug &&
              status == other.status &&
              link == other.link &&
              title == other.title &&
              content == other.content &&
              featuredMedia == other.featuredMedia &&
              phone == other.phone &&
              whatsapp == other.whatsapp &&
              address == other.address &&
              locationMap == other.locationMap &&
              featuredMediaUrl == other.featuredMediaUrl);

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      slug.hashCode ^
      status.hashCode ^
      link.hashCode ^
      title.hashCode ^
      content.hashCode ^
      featuredMedia.hashCode ^
      phone.hashCode ^
      whatsapp.hashCode ^
      address.hashCode ^
      locationMap.hashCode ^
      featuredMediaUrl.hashCode;

  @override
  String toString() {
    return 'CarProtectionFilm{' +
        ' id: $id,' +
        ' date: $date,' +
        ' slug: $slug,' +
        ' status: $status,' +
        ' link: $link,' +
        ' title: $title,' +
        ' content: $content,' +
        ' featuredMedia: $featuredMedia,' +
        ' phone: $phone,' +
        ' whatsapp: $whatsapp,' +
        ' address: $address,' +
        ' mapLocation: $locationMap,' +
        ' featuredMediaUrl: $featuredMediaUrl,' +
        '}';
  }

  CarProtectionFilm copyWith({
    int? id,
    String? date,
    String? slug,
    String? status,
    String? link,
    String? title,
    String? content,
    int? featuredMedia,
    String? phone,
    String? whatsapp,
    String? address,
    String? mapLocation,
    String? featuredMediaUrl,
  }) {
    return CarProtectionFilm(
      id: id ?? this.id,
      date: date ?? this.date,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      link: link ?? this.link,
      title: title ?? this.title,
      content: content ?? this.content,
      featuredMedia: featuredMedia ?? this.featuredMedia,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      locationMap: mapLocation ?? this.locationMap,
      featuredMediaUrl: featuredMediaUrl ?? this.featuredMediaUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'date': this.date,
      'slug': this.slug,
      'status': this.status,
      'link': this.link,
      'title': this.title,
      'content': this.content,
      'featured_media': this.featuredMedia,
      'phone': this.phone,
      'whatsapp': this.whatsapp,
      'address': this.address,
      'map_location': this.locationMap,
      'featured_media_url': this.featuredMediaUrl,
    };
  }

  factory CarProtectionFilm.fromMap(Map<String, dynamic> map) {
    return CarProtectionFilm(
      id: map['id'] ?? 0,
      date: map['date'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      link: map['link'] ?? '',
      title: map['title']?['rendered'] ?? '', // Extract the rendered title
      content: map['content']?['rendered'] ?? '', // Extract the rendered content
      featuredMedia: map['featured_media'] ?? 0,
      phone: map['acf']?['phone'] ?? '',
      whatsapp: map['acf']?['whatsapp'] ?? '',
      address: map['acf']?['address'] ?? '',
      locationMap: map['acf']?['map_loction'] ?? '', // Corrected key name
      featuredMediaUrl: map['_embedded']?['wp:featuredmedia']?[0]?['media_details']?['sizes']?['thumbnail']?['source_url'], // Extract the featured media URL
    );
  }
}