class ServiceCenter {
  final int id;
  final String date;
  final String dateGmt;
  final Guid guid;
  final String modified;
  final String modifiedGmt;
  final String slug;
  final String status;
  final String type;
  final String link;
  final Title title;
  final Content content;
  final int featuredMedia;
  final String template;
  final Acf acf;
  final String featuredImage;
  final Meta meta;

  ServiceCenter({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.featuredMedia,
    required this.template,
    required this.acf,
    required this.featuredImage,
    required this.meta,
  });

  factory ServiceCenter.fromJson(Map<String, dynamic> json) {
    return ServiceCenter(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      dateGmt: json['date_gmt'] ?? '',
      guid: Guid.fromJson(json['guid'] ?? {}),
      modified: json['modified'] ?? '',
      modifiedGmt: json['modified_gmt'] ?? '',
      slug: json['slug'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      link: json['link'] ?? '',
      title: Title.fromJson(json['title'] ?? {}),
      content: Content.fromJson(json['content'] ?? {}),
      featuredMedia: json['featured_media'] ?? 0,
      template: json['template'] ?? '',
      acf: json['acf'] != null ? Acf.fromJson(json['acf']) : Acf.defaultAcf(),
      featuredImage: json['featured_image'] ?? '',
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }
}

class Acf {
  final String phone;
  final String whatsapp;
  final String address;
  final String mapLocation;

  Acf({
    required this.phone,
    required this.whatsapp,
    required this.address,
    required this.mapLocation,
  });

  factory Acf.fromJson(Map<String, dynamic> json) {
    return Acf(
      phone: json['phone_number']?.toString() ?? '',
      whatsapp: json['whatsapp']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      mapLocation: json['address_loction']?.toString() ?? '',
    );
  }

  factory Acf.defaultAcf() {
    return Acf(phone: '', whatsapp: '', address: '', mapLocation: '');
  }
}

class Meta {
  final bool acfChanged;

  Meta({required this.acfChanged});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(acfChanged: json['_acf_changed'] ?? false);
  }
}

class Guid {
  final String rendered;

  Guid({required this.rendered});

  factory Guid.fromJson(Map<String, dynamic> json) {
    return Guid(rendered: json['rendered'] ?? '');
  }
}

class Title {
  final String rendered;

  Title({required this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(rendered: json['rendered'] ?? '');
  }
}

class Content {
  final String rendered;
  final bool protected;

  Content({required this.rendered, required this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      rendered: json['rendered'] ?? '',
      protected: json['protected'] ?? false,
    );
  }
}
