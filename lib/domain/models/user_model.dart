class UserModel {
  final int? id;
  final String name;
  final String email;
  final bool? isActive;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updateAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.isActive,
    this.password,
    this.createdAt,
    this.updateAt,
  });

  bool verifyPassword(String hash) {
    return password?.compareTo(hash) == 0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['isActive'] = isActive;
    data['password'] = password;
    if (createdAt != null) {
      data['createdAt'] = createdAt;
    }
    if (updateAt != null) {
      data['updateAt'] = updateAt;
    }

    return data;
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    bool? isActive,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      password: password ?? this.password,
      createdAt: createdAt,
      updateAt: updateAt,
    );
  }
}
