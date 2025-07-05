class ResetPasswordModel {
  //<editor-fold desc="Data Methods">

  const ResetPasswordModel({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResetPasswordModel &&
          runtimeType == other.runtimeType &&
          oldPassword == other.oldPassword &&
          newPassword == other.newPassword);

  @override
  int get hashCode => oldPassword.hashCode ^ newPassword.hashCode;

  @override
  String toString() {
    return 'ResetPasswordModel{' +
        ' old_password: $oldPassword,' +
        ' newPassword: $newPassword,' +
        '}';
  }

  ResetPasswordModel copyWith({
    String? oldPassword,
    String? newPassword,
  }) {
    return ResetPasswordModel(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'old_password': this.oldPassword,
      'new_password': this.newPassword,
    };
  }

  factory ResetPasswordModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordModel(
      oldPassword: map['old_password'] as String,
      newPassword: map['ew_password'] as String,
    );
  }

  //</editor-fold>
  final String oldPassword;
  final String newPassword;}