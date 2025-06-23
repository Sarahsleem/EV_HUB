class UserModel {
  final int id;
  final String name;
  final String url;
  final String description;
  final String link;
  final String slug;
  final Map<String, String> avatarUrls;
  final List<dynamic> meta;
  final List<dynamic> acf;
  final String profileImage;
  final String elementorIntroduction;
  final String phoneNumber;
  final dynamic links;


  UserModel({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
    required this.link,
    required this.slug,
    required this.avatarUrls,
    required this.meta,
    required this.acf,
    required this.profileImage,
    required this.elementorIntroduction,
    required this.phoneNumber,
    required this.links,
  });

  // Factory method to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      slug: json['slug'] ?? '',
      avatarUrls: json['avatar_urls'] != null
          ? Map<String, String>.from(
        json['avatar_urls'].map((key, value) => MapEntry(key.toString(), value.toString())),
      )
          : {},
      meta: json['meta'] ?? [],
      acf: json['acf'] ?? [],
      elementorIntroduction: json['elementor_introduction'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      links: json['_links'] ?? {},
      profileImage: json['profile_image'] ?? '',
    );
  }
  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, phoneNumber: $phoneNumber, profileImage: $profileImage}';
  }


  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'description': description,
      'link': link,
      'slug': slug,
      'avatar_urls': avatarUrls,
      'meta': meta,
      'acf': acf,
      'profile_image': profileImage,
      'elementor_introduction': elementorIntroduction,
      'phone_number': phoneNumber,
      '_links': links,
    };
  }
}