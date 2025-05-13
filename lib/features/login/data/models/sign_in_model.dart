class SignIn {
  String? phone;
  String? password;

//<editor-fold desc="Data Methods">
  SignIn({
    this.phone,
    this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is SignIn &&
              runtimeType == other.runtimeType &&
              phone == other.phone &&
              password == other.password);

  @override
  int get hashCode => phone.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'SignIn{' + ' phone: $phone,' + ' password: $password,' + '}';
  }

  SignIn copyWith({
    String? phone,
    String? password,
  }) {
    return SignIn(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': this.phone,
      'password': this.password,
    };
  }

  factory SignIn.fromMap(Map<String, dynamic> map) {
    return SignIn(
      phone: map['phone'] ,
      password: map['password'] ,
    );
  }

//</editor-fold>
}