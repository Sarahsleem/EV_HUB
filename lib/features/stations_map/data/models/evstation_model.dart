class EVChargingStation {
  final String id;
  final String name;
  final String formattedAddress;
  final String shortFormattedAddress;
  final String nationalPhoneNumber;
  final String internationalPhoneNumber;
  final double latitude;
  final double longitude;
  final double rating;
  final int userRatingCount;
  final String googleMapsUri;
  final String websiteUri;
  final List<String> types;
  final List<String> weekdayDescriptions;
  final List<Review> reviews;
  final int connectorCount;
  final List<Connector> connectors;
  final List<AddressComponent> addressComponents;

  EVChargingStation({
    required this.id,
    required this.name,
    required this.formattedAddress,
    required this.shortFormattedAddress,
    required this.nationalPhoneNumber,
    required this.internationalPhoneNumber,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.userRatingCount,
    required this.googleMapsUri,
    required this.websiteUri,
    required this.types,
    required this.weekdayDescriptions,
    required this.reviews,
    required this.connectorCount,
    required this.connectors,
    required this.addressComponents,
  });

  factory EVChargingStation.fromJson(Map<String, dynamic> json) {
    return EVChargingStation(
      id: json['id'] ?? '',
      name: json['displayName']?['text'] ?? '',
      formattedAddress: json['formattedAddress'] ?? '',
      shortFormattedAddress: json['shortFormattedAddress'] ?? '',
      nationalPhoneNumber: json['nationalPhoneNumber'] ?? '',
      internationalPhoneNumber: json['internationalPhoneNumber'] ?? '',
      latitude: json['location']?['latitude'] ?? 0.0,
      longitude: json['location']?['longitude'] ?? 0.0,
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingCount: json['userRatingCount'] ?? 0,
      googleMapsUri: json['googleMapsUri'] ?? '',
      websiteUri: json['websiteUri'] ?? '',
      types: List<String>.from(json['types'] ?? []),
      weekdayDescriptions: List<String>.from(
        json['regularOpeningHours']?['weekdayDescriptions'] ?? [],
      ),
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => Review.fromJson(e))
          .toList(),
      connectorCount: json['evChargeOptions']?['connectorCount'] ?? 0,
      connectors: (json['evChargeOptions']?['connectorAggregation'] as List<dynamic>? ?? [])
          .map((e) => Connector.fromJson(e))
          .toList(),
      addressComponents: (json['addressComponents'] as List<dynamic>? ?? [])
          .map((e) => AddressComponent.fromJson(e))
          .toList(),
    );
  }
}

class Review {
  final String author;
  final String profilePhoto;
  final String url;
  final String relativeTime;
  final int rating;

  Review({
    required this.author,
    required this.profilePhoto,
    required this.url,
    required this.relativeTime,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['authorAttribution']?['displayName'] ?? '',
      profilePhoto: json['authorAttribution']?['photoUri'] ?? '',
      url: json['authorAttribution']?['uri'] ?? '',
      relativeTime: json['relativePublishTimeDescription'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }
}

class Connector {
  final String type;
  final double maxChargeRateKw;
  final int count;

  Connector({
    required this.type,
    required this.maxChargeRateKw,
    required this.count,
  });

  factory Connector.fromJson(Map<String, dynamic> json) {
    return Connector(
      type: json['type'] ?? '',
      maxChargeRateKw: (json['maxChargeRateKw'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }
}

class AddressComponent {
  final String longText;
  final String shortText;
  final List<String> types;
  final String languageCode;

  AddressComponent({
    required this.longText,
    required this.shortText,
    required this.types,
    required this.languageCode,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longText: json['longText'] ?? '',
      shortText: json['shortText'] ?? '',
      types: List<String>.from(json['types'] ?? []),
      languageCode: json['languageCode'] ?? '',
    );
  }
}
