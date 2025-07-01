class CompanyInfo {
  final String phoneNumber;
  final String whatsapp;
  final String address;
  final Location addressLocation;
  final String companyImage;
  final String cover;
  final String website;

  CompanyInfo({
    required this.phoneNumber,
    required this.whatsapp,
    required this.address,
    required this.addressLocation,
    required this.companyImage,
    required this.cover,
    required this.website,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      phoneNumber: json['phone_number'],
      whatsapp: json['whatsapp'],
      address: json['address'],
      addressLocation: Location.fromJson(json['address_loction']),
      companyImage: json['company_image'],
      cover: json['cover'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'whatsapp': whatsapp,
      'address': address,
      'address_loction': addressLocation.toJson(),
      'company_image': companyImage,
      'cover': cover,
      'website': website,
    };
  }
}
class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

