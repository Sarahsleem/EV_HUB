class CompanyModel {
  final int id;
  final String userLogin;
  final String userEmail;
  final String displayName;
  final String profileImage;

  final String phoneNumber;
  final String bio;
  final String location;
  final List<String> roles;

  CompanyModel({
    required this.id,
    required this.userLogin,
    required this.userEmail,
    required this.displayName,
    required this.profileImage,
    required this.phoneNumber,
    required this.bio,
    required this.location,
    required this.roles,
  });

  // تحويل JSON إلى كائن CompanyModel
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['ID'] ?? 0,
      userLogin: json['user_login'] ?? '',
      userEmail: json['user_email'] ?? '',
      displayName: json['display_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      bio: json['bio'] ?? '',
      location: json['location'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  // تحويل كائن CompanyModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'user_login': userLogin,
      'user_email': userEmail,
      'display_name': displayName,
      'profile_image': profileImage,
      'phone_number': phoneNumber,
      'bio': bio,
      'location': location,
      'roles': roles,
    };
  }

  @override
  String toString() {
    return 'CompanyModel(id: $id, userLogin: $userLogin, userEmail: $userEmail, displayName: $displayName, profileImage: $profileImage, phoneNumber: $phoneNumber, bio: $bio, location: $location, roles: $roles)';
  }
}
