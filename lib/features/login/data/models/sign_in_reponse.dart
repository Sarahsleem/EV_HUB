class Data {
  String? message;
  int? userId;
  String? authToken;

//<editor-fold desc="Data Methods">
  Data({
    this.message,
    this.userId,
    this.authToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Data &&
              runtimeType == other.runtimeType &&
              message == other.message &&
              userId == other.userId &&
              authToken == other.authToken);

  @override
  int get hashCode => message.hashCode ^ userId.hashCode ^ authToken.hashCode;

  @override
  String toString() {
    return 'Data{' +
        ' message: $message,' +
        ' userId: $userId,' +
        ' auth_token: $authToken,' +
        '}';
  }

  Data copyWith({
    String? message,
    int? userId,
    String? authToken,
  }) {
    return Data(
      message: message ?? this.message,
      userId: userId ?? this.userId,
      authToken: authToken ?? this.authToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'userId': this.userId,
      'auth_token': this.authToken,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      message: map['message'] ,
      userId: map['userId'],
      authToken: map['auth_token'] ,
    );
  }

//</editor-fold>
}
class SignInResponse {
  bool? success;
  Data? data;

//<editor-fold desc="Data Methods">
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
    return 'SignInResponse{' + ' success: $success,' + ' data: $data,' + '}';
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
      'success': this.success,
      'data': this.data,
    };
  }

  factory SignInResponse.fromMap(Map<String, dynamic> map) {
    return SignInResponse(
      success: map['success'] as bool,
      data: map['data'] != null ? Data.fromMap(map['data']) : null,
    );
  }


//</editor-fold>
}