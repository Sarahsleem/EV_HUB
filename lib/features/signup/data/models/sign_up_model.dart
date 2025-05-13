class SignUp {
  String? name;
  String? phone;
  String? email;
  String? password;

//<editor-fold desc="Data Methods">
  SignUp({
    this.name,
    this.phone,
    this.email,
    this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is SignUp &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              phone == other.phone &&
              email == other.email &&
              password == other.password);

  @override
  int get hashCode =>
      name.hashCode ^ phone.hashCode ^ email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'SignIn{' +
        ' name: $name,' +
        ' phone: $phone,' +
        ' email: $email,' +
        ' password: $password,' +
        '}';
  }

  SignUp copyWith({
    String? name,
    String? phone,
    String? email,
    String? password,
  }) {
    return SignUp(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'phone': this.phone,
      'email': this.email,
      'password': this.password,
    };
  }

  factory SignUp.fromMap(Map<String, dynamic> map) {
    return SignUp(
      name: map['name'] ,
      phone: map['phone'] ,
      email: map['email'] ,
      password: map['password'] ,
    );
  }

//</editor-fold>
}