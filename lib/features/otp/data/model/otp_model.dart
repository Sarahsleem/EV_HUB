class OTPModel {
  final String? otp;
  final String? email;

  //<editor-fold desc="Data Methods">
  const OTPModel({
    this.otp,
    this.email,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is OTPModel &&
              runtimeType == other.runtimeType &&
              otp == other.otp &&
              email == other.email
          );


  @override
  int get hashCode =>
      otp.hashCode ^
      email.hashCode;


  @override
  String toString() {
    return 'OTPModel{' +
        ' otp: $otp,' +
        ' email: $email,' +
        '}';
  }


  OTPModel copyWith({
    String? otp,
    String? email,
  }) {
    return OTPModel(
      otp: otp ?? this.otp,
      email: email ?? this.email,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'code': this.otp,
      'email': this.email,
    };
  }

  factory OTPModel.fromMap(Map<String, dynamic> map) {
    return OTPModel(
      otp: map['code'] as String,
      email: map['email'] as String,
    );
  }


//</editor-fold>
}
