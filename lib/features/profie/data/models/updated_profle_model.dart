class UpdatedProfileModel{
  final String? name;
  final String? email;
  final String? phone;
  final String? image;

//<editor-fold desc="Data Methods">
  const UpdatedProfileModel({
    this.name,
    this.email,
    this.phone,this.image
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UpdatedProfileModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          phone == other.phone);

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ phone.hashCode;

  @override
  String toString() {
    return 'UpdatedProfileModel{' +
        ' name: $name,' +
        ' email: $email,' +
        ' phone: $phone,' +
        '}';
  }

  UpdatedProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return UpdatedProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'profile_image': this.image
    };
  }

  factory UpdatedProfileModel.fromMap(Map<String, dynamic> map) {
    return UpdatedProfileModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      image: map['profile_image']
    );
  }

//</editor-fold>
}