class CarServicesModel{
  final String image;
  final String title;
  final String description;
  final Function()? onTap;

  //<editor-fold desc="Data Methods">
  const CarServicesModel({
    required this.image,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarServicesModel &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          title == other.title &&
          description == other.description &&
          onTap == other.onTap);

  @override
  int get hashCode =>
      image.hashCode ^ title.hashCode ^ description.hashCode ^ onTap.hashCode;

  @override
  String toString() {
    return 'CarServicesModel{' +
        ' image: $image,' +
        ' title: $title,' +
        ' description: $description,' +
        ' onTap: $onTap,' +
        '}';
  }

  CarServicesModel copyWith({
    String? image,
    String? title,
    String? description,
    Function()? onTap,
  }) {
    return CarServicesModel(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      onTap: onTap ?? this.onTap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'title': this.title,
      'description': this.description,
      'onTap': this.onTap,
    };
  }

  factory CarServicesModel.fromMap(Map<String, dynamic> map) {
    return CarServicesModel(
      image: map['image'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      onTap: map['onTap'] as Function(),
    );
  }

  //</editor-fold>
}