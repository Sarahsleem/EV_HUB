class  Car {
  final int? id;
  final String? date;
  final String? dateGmt;
  final String? modified;
  final String? modifiedGmt;
  final String? slug;
  final String? status;
  final String? type;
  final String? link;
  final String? title;
  final int? author;
  final String? content;
  final int? featuredMedia;
  final String? template;
  final Map<String, dynamic>? meta;
  final List<dynamic>? bodyStyle;
  final List<dynamic>? carBrand;
  final List<dynamic>? carClass;
  final List<dynamic>? color;
  final List<dynamic>? model;
  final List<dynamic>? usedSince;
  final List<dynamic>? classList;
  final List<dynamic>? condition;
  final Map<String, dynamic>? acf;
  final Map<String, dynamic>? links;
  final String? featuredImage;

//<editor-fold desc="Data Methods">
  const Car({
    this.id,
    this.date,
    this.dateGmt,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.author,
    this.content,
    this.featuredMedia,
    this.template,
    this.meta,
    this.bodyStyle,
    this.carBrand,
    this.carClass,
    this.color,
    this.model,
    this.usedSince,
    this.classList,
    this.condition,
    this.acf,
    this.links,
    this.featuredImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Car &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              date == other.date &&
              dateGmt == other.dateGmt &&
              modified == other.modified &&
              modifiedGmt == other.modifiedGmt &&
              slug == other.slug &&
              status == other.status &&
              type == other.type &&
              link == other.link &&
              title == other.title &&
              author == other.author &&
              content == other.content &&
              featuredMedia == other.featuredMedia &&
              template == other.template &&
              meta == other.meta &&
              bodyStyle == other.bodyStyle &&
              carBrand == other.carBrand &&
              carClass == other.carClass &&
              color == other.color &&
              model == other.model &&
              usedSince == other.usedSince &&
              classList == other.classList &&
              condition == other.condition &&
              acf == other.acf &&
              links == other.links &&
              featuredImage == other.featuredImage);

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      dateGmt.hashCode ^
      modified.hashCode ^
      modifiedGmt.hashCode ^
      slug.hashCode ^
      status.hashCode ^
      type.hashCode ^
      link.hashCode ^
      title.hashCode ^
      author.hashCode ^
      content.hashCode ^
      featuredMedia.hashCode ^
      template.hashCode ^
      meta.hashCode ^
      bodyStyle.hashCode ^
      carBrand.hashCode ^
      carClass.hashCode ^
      color.hashCode ^
      model.hashCode ^
      usedSince.hashCode ^
      classList.hashCode ^
      condition.hashCode ^
      acf.hashCode ^
      links.hashCode ^
      featuredImage.hashCode;

  @override
  String toString() {
    return 'Car{' +
        ' id: $id,' +
        ' date: $date,' +
        ' dateGmt: $dateGmt,' +
        ' modified: $modified,' +
        ' modifiedGmt: $modifiedGmt,' +
        ' slug: $slug,' +
        ' status: $status,' +
        ' type: $type,' +
        ' link: $link,' +
        ' title: $title,' +
        ' author: $author,' +
        ' content: $content,' +
        ' featuredMedia: $featuredMedia,' +
        ' template: $template,' +
        ' meta: $meta,' +
        ' bodyStyle: $bodyStyle,' +
        ' carBrand: $carBrand,' +
        ' carClass: $carClass,' +
        ' color: $color,' +
        ' model: $model,' +
        ' usedSince: $usedSince,' +
        ' classList: $classList,' +
        ' condition: $condition,' +
        ' acf: $acf,' +
        ' links: $links,' +
        ' featuredImage: $featuredImage,' +
        '}';
  }

  Car copyWith({
    int? id,
    String? date,
    String? dateGmt,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    String? title,
    int? author,
    String? content,
    int? featuredMedia,
    String? template,
    Map<String, dynamic>? meta,
    List<dynamic>? bodyStyle,
    List<dynamic>? carBrand,
    List<dynamic>? carClass,
    List<dynamic>? color,
    List<dynamic>? model,
    List<dynamic>? usedSince,
    List<dynamic>? classList,
    List<dynamic>? condition,
    Map<String, dynamic>? acf,
    Map<String, dynamic>? links,
    String? featuredImage,
  }) {
    return Car(
      id: id ?? this.id,
      date: date ?? this.date,
      dateGmt: dateGmt ?? this.dateGmt,
      modified: modified ?? this.modified,
      modifiedGmt: modifiedGmt ?? this.modifiedGmt,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      type: type ?? this.type,
      link: link ?? this.link,
      title: title ?? this.title,
      author: author ?? this.author,
      content: content ?? this.content,
      featuredMedia: featuredMedia ?? this.featuredMedia,
      template: template ?? this.template,
      meta: meta ?? this.meta,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      carBrand: carBrand ?? this.carBrand,
      carClass: carClass ?? this.carClass,
      color: color ?? this.color,
      model: model ?? this.model,
      usedSince: usedSince ?? this.usedSince,
      classList: classList ?? this.classList,
      condition: condition ?? this.condition,
      acf: acf ?? this.acf,
      links: links ?? this.links,
      featuredImage: featuredImage ?? this.featuredImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'date': this.date,
      'date_gmt': this.dateGmt,
      'modified': this.modified,
      'modified_gmt': this.modifiedGmt,
      'slug': this.slug,
      'status': this.status,
      'type': this.type,
      'link': this.link,
      'title': this.title,
      'author': this.author,
      'content': this.content,
      'featured_media': this.featuredMedia,
      'template': this.template,
      'meta': this.meta,
      'body_style': this.bodyStyle,
      'car_brand': this.carBrand,
      'car_class': this.carClass,
      'color': this.color,
      'model': this.model,
      'used_since': this.usedSince,
      'class_list': this.classList,
      'condition': this.condition,
      'acf': this.acf,
      'links': this.links,
      'featured_image': this.featuredImage,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic>? acfData = map['acf'];

    double? parseDouble(dynamic value) {
      if (value == null || value == "" || value == "N/A") return null;
      return double.tryParse(value.toString());
    }

    return Car(
      id: map['id'],
      date: map['date'],
      dateGmt: map['date_gmt'],
      modified: map['modified'],
      modifiedGmt: map['modified_gmt'],
      slug: map['slug'],
      status: map['status'],
      type: map['type'],
      link: map['link'],
      author: map['author'],
      title: map['title']?['rendered'] ?? '',
      content:_removeHtmlTags( map['content']?['rendered']),
      featuredMedia: map['featured_media'],
      template: map['template'],
      meta: map['meta'],
      bodyStyle: List<dynamic>.from(map['body-style'] ?? [9]),
      carBrand: List<dynamic>.from(map['car-brand'] ?? []),
      carClass: List<dynamic>.from(map['class'] ?? []),
      color: List<dynamic>.from(map['color'] ?? []),
      model: List<dynamic>.from(map['model'] ?? []),
      usedSince: List<dynamic>.from(map['used-since'] ?? []),
      condition: List<dynamic>.from(map['condition'] ?? []),
      classList: List<dynamic>.from(map['class_list'] ?? []),
      featuredImage: map['featured_image'],
      acf: {
        "km": parseDouble(acfData?['km']),
        "price": parseDouble(acfData?['price']),
        "battery_capacity": parseDouble(acfData?['battery_capacity']),
        "range_per_charge_km": parseDouble(acfData?['range_per_charge:_km']),
        "compatible_charger_type": acfData?['compatible_charger_type:'],
        "motor_power_hp": parseDouble(acfData?['motor_power:_electric_horsepower_hp']),
        "car_images": acfData?['car_images'] ?? [],
      },
      links: map['_links'],
    );
  }
  static String _removeHtmlTags(String? text) {
    if (text == null) return '';
    final RegExp regExp = RegExp(r'<[^>]*>');
    return text.replaceAll(regExp, '');
  }
//</editor-fold>
}