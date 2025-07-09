class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? image;

//<editor-fold desc="Data Methods">


  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          role == other.role &&
          image == other.image);

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      role.hashCode ^
      image.hashCode;

  @override
  String toString() {
    return 'ProfileModel{' +
        ' name: $name,' +
        ' email: $email,' +
        ' phoneumber: $phoneNumber,' +
        ' role: $role,' +
        ' image: $image,' +
        '}';
  }

  ProfileModel copyWith({
    int?id,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    String? image,
  }) {
    return ProfileModel(
      id: id??this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'phone': this.phoneNumber,
      'role': this.role,
      'profile_image': this.image,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['user_id'],
      name: map['name'] ,
      email: map['email'] ,
      phoneNumber: map['phone'] ,
      role: map['role'] ,
      image: map['profile_image'] ,
    );
  }

//</editor-fold>
}