class Data {
  String? message;
  int? userId;
  String? phone;
  String? authToken;
  String? role;

  Data({
    this.message,
    this.userId,
    this.phone,
    this.authToken,
    this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Data &&
              runtimeType == other.runtimeType &&
              message == other.message &&
              userId == other.userId &&
              phone == other.phone &&
              authToken == other.authToken &&
              role == other.role);

  @override
  int get hashCode =>
      message.hashCode ^ userId.hashCode ^ phone.hashCode ^ authToken.hashCode ^ role.hashCode;

  @override
  String toString() {
    return 'Data{ message: $message, userId: $userId, phone: $phone, authToken: $authToken, role: $role }';
  }

  Data copyWith({
    String? message,
    int? userId,
    String? phone,
    String? authToken,
    String? role,
  }) {
    return Data(
      message: message ?? this.message,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
      authToken: authToken ?? this.authToken,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'user_id': userId,
      'phone': phone,
      'auth_token': authToken,
      'role': role,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      message: map['message'] as String?,
      userId: map['user_id'] as int?,
      phone: map['phone'] as String?,
      authToken: map['auth_token'] as String?,
      role: map['role'] as String?,
    );
  }
}

class SignInResponse {
  bool? success;
  Data? data;

  SignInResponse({
    this.success,
    this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is SignInResponse &&
              runtimeType == other.runtimeType &&
              success == other.success &&
              data == other.data);

  @override
  int get hashCode => success.hashCode ^ data.hashCode;

  @override
  String toString() {
    return 'SignInResponse{ success: $success, data: $data }';
  }

  SignInResponse copyWith({
    bool? success,
    Data? data,
  }) {
    return SignInResponse(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data?.toMap(),
    };
  }

  factory SignInResponse.fromMap(Map<String, dynamic> map) {
    return SignInResponse(
      success: map['success'] as bool?,
      data: map['data'] != null ? Data.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }
}
