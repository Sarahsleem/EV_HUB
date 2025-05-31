class CarRequestModel {
  String? title;
  String? status;
  String? content;
  List<int>? carBrand;
  List<int>? bodyStyle;
  List<int>? usedSince;
  List<int>? condition;
  int? featuredImage;
  Fields? fields;
  List<int>? carImages;
  CarRequestModel(
      {this.title,
        this.status,
        this.content,
        this.carBrand,
        this.bodyStyle,
        this.carImages,
        this.usedSince,
        this.condition,
        this.featuredImage,
        this.fields});

  CarRequestModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    content = json['content'];
    carBrand = json['car-brand'].cast<int>();
    bodyStyle = json['body-style'].cast<int>();
    usedSince = json['used-since'].cast<int>();
    condition = json['condition'].cast<int>();
    featuredImage = json['featured_media'];
    carImages = json['car_images'].cast<int>();
    fields =
    json['fields'] != null ? new Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['content'] = this.content;
    data['car-brand'] = this.carBrand;
    data['body-style'] = this.bodyStyle;
    data['used-since'] = this.usedSince;
    data['condition'] = this.condition;
    data['car_images'] = this.carImages;
    data['featured_media'] = this.featuredImage;
    if (this.fields != null) {
      data['fields'] = this.fields!.toJson();
    }
    return data;
  }
}

class Fields {

  String? price;
  String? km;
  String? location;
  String? rangePerChargeKm;
  String? compatibleChargerType;
  String? batteryCapacity;
  String? motorPowerElectricHorsepowerHp;

  Fields(
      {
        this.price,
        this.km,
        this.location,
        this.rangePerChargeKm,
        this.compatibleChargerType,
        this.batteryCapacity,
        this.motorPowerElectricHorsepowerHp});

  Fields.fromJson(Map<String, dynamic> json) {

    price = json['price'];
    km = json['km'];

    rangePerChargeKm = json['range_per_charge:_km'];
    compatibleChargerType = json['compatible_charger_type:'];
    batteryCapacity = json['battery_capacity'];
    motorPowerElectricHorsepowerHp =
    json['motor_power:_electric_horsepower_hp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['price'] = this.price;
    data['km'] = this.km;

    data['range_per_charge:_km'] = this.rangePerChargeKm;
    data['compatible_charger_type:'] = this.compatibleChargerType;
    data['battery_capacity'] = this.batteryCapacity;
    data['motor_power:_electric_horsepower_hp'] =
        this.motorPowerElectricHorsepowerHp;
    return data;
  }
}
