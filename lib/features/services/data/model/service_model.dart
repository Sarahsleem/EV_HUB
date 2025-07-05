import 'car_acc_model.dart';

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
  final String title;
  final String content;
  final int featuredMedia;
  final String template;
  final Acf acf;
  final Ratings? ratings;

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
    this.ratings,
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
      title:  json['title']['rendered']??'',
      content: json['content']["rendered"] ?? '',
      featuredMedia: json['featured_media'] ?? 0,
      template: json['template'] ?? '',
      acf: Acf.fromJson(json['acf'] ?? {}),
      ratings: Ratings.fromJson(json['ratings']),
      featuredImage: json['featured_image'] ?? '',
      meta: Meta.fromJson(json['meta'] ?? {}),
    );
  }
}

class Acf {
  final String phoneNumber;
  final String whatsapp;
  final String address;
  final String addressLocation;
  final String? companyImage;
  final CoverModel? cover;
  final String? website;

  Acf({
    required this.phoneNumber,
    required this.whatsapp,
    required this.address,
    required this.addressLocation,
     this.companyImage,
    this.cover,
    this.website,
  });

  factory Acf.fromJson(Map<String, dynamic> json) {
    return Acf(
      phoneNumber: json['phone_number'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      address: json['address'] ?? '',
      addressLocation: json['address_loction'] ?? '',
     // companyImage: json['company_image'] ?? '',
      cover: json['cover'] != null ? CoverModel.fromJson(json['cover']) : null,
     website: json['website'],
    );
  }
}
class CoverModel {
  final int id;
  final String title;
  final String filename;
  final int filesize;
  final String url;
  final String link;
  final String alt;
  final String author;
  final String description;
  final String caption;
  final String name;
  final String status;
  final int uploadedTo;
  final String date;
  final String modified;
  final int menuOrder;
  final String mimeType;
  final String type;
  final String subtype;
  final String icon;
  final int width;
  final int height;

  CoverModel({
    required this.id,
    required this.title,
    required this.filename,
    required this.filesize,
    required this.url,
    required this.link,
    required this.alt,
    required this.author,
    required this.description,
    required this.caption,
    required this.name,
    required this.status,
    required this.uploadedTo,
    required this.date,
    required this.modified,
    required this.menuOrder,
    required this.mimeType,
    required this.type,
    required this.subtype,
    required this.icon,
    required this.width,
    required this.height,
  });

  factory CoverModel.fromJson(Map<String, dynamic> json) {
    return CoverModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      filename: json['filename'] ?? '',
      filesize: json['filesize'] ?? 0,
      url: json['url'] ?? '',
      link: json['link'] ?? '',
      alt: json['alt'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      caption: json['caption'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      uploadedTo: json['uploaded_to'] ?? 0,
      date: json['date'] ?? '',
      modified: json['modified'] ?? '',
      menuOrder: json['menu_order'] ?? 0,
      mimeType: json['mime_type'] ?? '',
      type: json['type'] ?? '',
      subtype: json['subtype'] ?? '',
      icon: json['icon'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,

    );
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
