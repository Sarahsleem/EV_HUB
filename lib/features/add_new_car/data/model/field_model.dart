class fieldsModel {
  int id;
  String name;

  fieldsModel({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is fieldsModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'fieldsModel{' + ' id: $id,' + ' name: $name,' + '}';
  }

  fieldsModel copyWith({
    int? id,
    String? name,
  }) {
    return fieldsModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory fieldsModel.fromMap(Map<String, dynamic> map) {
    return fieldsModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
