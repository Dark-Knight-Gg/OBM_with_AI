class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class LoginResponse {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final UserInfoModel? user;

  const LoginResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.user,
  });


  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] as String?,
      tokenType: json['tokenType'] as String?,
      expiresIn: json['expiresIn'] as int?,
      user: json['user'] != null
          ? UserInfoModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserInfoModel {
  final int? id;
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final List<String>? roles;

  const UserInfoModel({
    this.id,
    this.email,
    this.fullName,
    this.avatarUrl,
    this.roles,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'roles': roles,
    };
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
