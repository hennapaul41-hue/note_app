class SettingsModel {
  final String username;
  final String email;
  final String password;

  SettingsModel({
    required this.username,
    required this.email,
    required this.password,
  });

  // Copy with updated fields
  SettingsModel copyWith({String? username, String? email, String? password}) {
    return SettingsModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  // Convert to Map (for storage)
  Map<String, dynamic> toMap() {
    return {'username': username, 'email': email, 'password': password};
  }

  // Create from Map
  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // Convert to JSON
  String toJson() => toMap().toString();

  // Create from JSON (basic parsing)
  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Equality check
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsModel &&
        other.username == username &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ password.hashCode;
}
