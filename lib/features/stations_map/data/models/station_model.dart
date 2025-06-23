class Station {
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
  final Meta meta;
  final List<ConnectorStatus> connectorStatus;
  final List<String> classList;
  final Acf acf;
  final List<dynamic> aioseoNotices;
  final dynamic featuredImage;
  final Links links;

  Station({
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
    required this.meta,
    required this.connectorStatus,
    required this.classList,
    required this.acf,
    required this.aioseoNotices,
    required this.featuredImage,
    required this.links,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    // التحقق من وجود الحقول المطلوبة
    final Map<String, dynamic> acfData = json['acf'] ?? {}; // التأكد من أن acf ليست null
    final String mapL = acfData['map_L'] ?? '0.0'; // استخدام قيمة افتراضية إذا كانت null
    final String mapE = acfData['map_E'] ?? '0.0'; // استخدام قيمة افتراضية إذا كانت null

    return Station(
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
      meta: Meta.fromJson(json['meta'] ?? {}),
      connectorStatus: (json['connector-status'] as List?)
              ?.map((e) => ConnectorStatus.fromJson(e))
              .toList() ??
          [],
      classList: List<String>.from(json['class_list'] ?? []),
      acf: Acf(mapL: mapL, mapE: mapE), // استخدام البيانات المعدلة
      aioseoNotices: List.from(json['aioseo_notices'] ?? []),
      featuredImage: json['featured_image'],
      links: Links.fromJson(json['_links'] ?? {}),
    );
  }
}

// نفس الشيء ينطبق على بقية الكلاسات مثل:
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

class Meta {
  final bool acfChanged;

  Meta({required this.acfChanged});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(acfChanged: json['_acf_changed'] ?? false);
  }
}

class ConnectorStatus {
  final int id;
  final String name;
  final String slug;

  ConnectorStatus({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ConnectorStatus.fromJson(Map<String, dynamic> json) {
    return ConnectorStatus(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class Acf {
  final String mapL; // Latitude
  final String mapE; // Longitude

  Acf({required this.mapL, required this.mapE});

  factory Acf.fromJson(Map<String, dynamic> json) {
    return Acf(
      mapL: json['map_L'] ?? '0.0',
      mapE: json['map_E'] ?? '0.0',
    );
  }
}

class Links {
  final List<Link> self;
  final List<Link> collection;
  final List<Link> about;
  final List<Link> wpAttachment;
  final List<Link> wpTerm;
  final List<Link> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.wpAttachment,
    required this.wpTerm,
    required this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: (json['self'] as List?)?.map((e) => Link.fromJson(e)).toList() ?? [],
      collection: (json['collection'] as List?)
              ?.map((e) => Link.fromJson(e))
              .toList() ??
          [],
      about: (json['about'] as List?)
              ?.map((e) => Link.fromJson(e))
              .toList() ??
          [],
      wpAttachment: (json['wp:attachment'] as List?)
              ?.map((e) => Link.fromJson(e))
              .toList() ??
          [],
      wpTerm: (json['wp:term'] as List?)
              ?.map((e) => Link.fromJson(e))
              .toList() ??
          [],
      curies: (json['curies'] as List?)
              ?.map((e) => Link.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Link {
  final String href;
  final TargetHints targetHints;

  Link({required this.href, required this.targetHints});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'] ?? '',
      targetHints: TargetHints.fromJson(json['targetHints'] ?? {}),
    );
  }
}

class TargetHints {
  final List<String> allow;

  TargetHints({required this.allow});

  factory TargetHints.fromJson(Map<String, dynamic> json) {
    return TargetHints(allow: List<String>.from(json['allow'] ?? []));
  }
}
