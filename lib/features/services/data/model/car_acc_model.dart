import '../../../services/data/model/service_model.dart';
import '../../../services/data/model/service_model.dart';

class CarAccessories {
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
  final String title;
  final String content;
  final int? featuredMedia;
  final String? template;
  final Meta? meta;
  final List<String> classList;
  final Acf acf;
  final String? featuredImage; // ✅ Added
  final Links? links;

  CarAccessories({
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
    this.featuredMedia,
    this.template,
    this.meta,
    required this.classList,
    required this.acf,
    this.featuredImage, // ✅ Added
    this.links,
  });

  factory CarAccessories.fromJson(Map<String, dynamic> json) {
    return CarAccessories(
      id: json['id'],
      date: json['date'],
      dateGmt: json['date_gmt'],
      guid: Guid.fromJson(json['guid']),
      modified: json['modified'],
      modifiedGmt: json['modified_gmt'],
      slug: json['slug'],
      status: json['status'],
      type: json['type'],
      link: json['link'],
      title: json['title']['rendered']??'',
      content: json['content']["rendered"] ?? '',
      featuredMedia: json['featured_media'],
      template: json['template'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      classList: List<String>.from(json['class_list'] ?? []),
      acf: Acf.fromJson(json['acf'] ?? {}),
      featuredImage: json['featured_image'], // ✅ Added
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'date_gmt': dateGmt,
      'guid': guid.toJson(),
      'modified': modified,
      'modified_gmt': modifiedGmt,
      'slug': slug,
      'status': status,
      'type': type,
      'link': link,
      'title': title,
      'content': content,
      'featured_media': featuredMedia,
      'template': template,
      'meta': meta?.toJson(),
      'class_list': classList,

      'featured_image': featuredImage, // ✅ Added
      '_links': links?.toJson(),
    };
  }
}


class Guid {
  final String rendered;

  Guid({required this.rendered});

  factory Guid.fromJson(Map<String, dynamic> json) {
    return Guid(rendered: json['rendered']);
  }

  Map<String, dynamic> toJson() {
    return {'rendered': rendered};
  }
}

class Title {
  final String rendered;

  Title({required this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(rendered: json['rendered']);
  }

  Map<String, dynamic> toJson() {
    return {'rendered': rendered};
  }
}

class Content {
  final String rendered;
  final bool protected;

  Content({required this.rendered, required this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      rendered: json['rendered'],
      protected: json['protected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'rendered': rendered, 'protected': protected};
  }
}

class Meta {
  final bool acfChanged;

  Meta({required this.acfChanged});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(acfChanged: json['_acf_changed']);
  }

  Map<String, dynamic> toJson() {
    return {'_acf_changed': acfChanged};
  }
}



class Links {
  final List<LinkHref>? self;
  final List<LinkHref>? collection;
  final List<LinkHref>? about;
  final List<VersionHistory>? versionHistory;
  final List<LinkHref>? predecessorVersion;
  final List<LinkHref>? wpFeaturedMedia;
  final List<LinkHref>? wpAttachment;
  final List<Cury>? curies;

  Links({
    this.self,
    this.collection,
    this.about,
    this.versionHistory,
    this.predecessorVersion,
    this.wpFeaturedMedia,
    this.wpAttachment,
    this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'] != null
          ? (json['self'] as List).map((e) => LinkHref.fromJson(e)).toList()
          : null,
      collection: json['collection'] != null
          ? (json['collection'] as List).map((e) => LinkHref.fromJson(e)).toList()
          : null,
      about: json['about'] != null
          ? (json['about'] as List).map((e) => LinkHref.fromJson(e)).toList()
          : null,
      versionHistory: json['version-history'] != null
          ? (json['version-history'] as List)
          .map((e) => VersionHistory.fromJson(e))
          .toList()
          : null,
      predecessorVersion: json['predecessor-version'] != null
          ? (json['predecessor-version'] as List)
          .map((e) => LinkHref.fromJson(e))
          .toList()
          : null,
      wpFeaturedMedia: json['wp:featuredmedia'] != null
          ? (json['wp:featuredmedia'] as List)
          .map((e) => LinkHref.fromJson(e))
          .toList()
          : null,
      wpAttachment: json['wp:attachment'] != null
          ? (json['wp:attachment'] as List)
          .map((e) => LinkHref.fromJson(e))
          .toList()
          : null,
      curies: json['curies'] != null
          ? (json['curies'] as List).map((e) => Cury.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'self': self?.map((e) => e.toJson()).toList(),
      'collection': collection?.map((e) => e.toJson()).toList(),
      'about': about?.map((e) => e.toJson()).toList(),
      'version-history': versionHistory?.map((e) => e.toJson()).toList(),
      'predecessor-version': predecessorVersion?.map((e) => e.toJson()).toList(),
      'wp:featuredmedia': wpFeaturedMedia?.map((e) => e.toJson()).toList(),
      'wp:attachment': wpAttachment?.map((e) => e.toJson()).toList(),
      'curies': curies?.map((e) => e.toJson()).toList(),
    };
  }
}

class LinkHref {
  final String href;

  LinkHref({required this.href});

  factory LinkHref.fromJson(Map<String, dynamic> json) {
    return LinkHref(href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'href': href};
  }
}

class VersionHistory {
  final int count;
  final String href;

  VersionHistory({required this.count, required this.href});

  factory VersionHistory.fromJson(Map<String, dynamic> json) {
    return VersionHistory(
      count: json['count'],
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'href': href};
  }
}

class Cury {
  final String name;
  final String href;
  final bool templated;

  Cury({required this.name, required this.href, required this.templated});

  factory Cury.fromJson(Map<String, dynamic> json) {
    return Cury(
      name: json['name'],
      href: json['href'],
      templated: json['templated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'href': href, 'templated': templated};
  }
}
// class CarAccessories {
//   final int id;
//   final String date;
//   final String slug;
//   final String status;
//   final String link;
//   final String title;
//   final String content;
//   final int featuredMedia;
//   final Acf acf;
//   // final String phone;
//   // final String whatsapp;
//   // final String address;
//   // final String mapLocation;
//   final String featuredImage;
//
//   const CarAccessories({
//     required this.id,
//     required this.date,
//     required this.slug,
//     required this.status,
//     required this.link,
//     required this.title,
//     required this.content,
//     required this.featuredMedia,
//     required this.acf,
//     // required this.phone,
//     // required this.whatsapp,
//     // required this.address,
//     // required this.mapLocation,
//     required this.featuredImage,
//   });
//
//   factory CarAccessories.fromMap(Map<String, dynamic> map) {
//     return CarAccessories(
//       id: map['id'],
//       date: map['date'],
//       slug: map['slug'],
//       status: map['status'],
//       link: map['link'],
//       title: map['title']['rendered'],
//       content: map['content']['rendered'],
//       featuredMedia: map['featured_media'],
//       acf: map['acf'],
//       // phone: map['acf']['phone'],
//       // whatsapp: map['acf']['whatsapp'],
//       // address: map['acf']['address'],
//       // mapLocation: map['acf']['map_loction'],
//       featuredImage:map['featured_image'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'date': date,
//       'slug': slug,
//       'status': status,
//       'link': link,
//       'title': title,
//       'content': content,
//       'featuredMedia': featuredMedia,
//
//       'featured_image':featuredImage,
//     };
//   }
// }
