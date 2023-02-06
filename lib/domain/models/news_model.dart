class NewsModel {
  final int? id;
  final String title;
  final String description;
  final DateTime? createdAt;
  final DateTime? updateAt;
  final int userId;

  NewsModel({
    this.id,
    required this.title,
    required this.description,
    this.createdAt,
    this.updateAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) {
      data['id'] = id;
    }
    data['title'] = title;
    data['description'] = description;
    if (createdAt != null) {
      data['createdAt'] = createdAt.toString();
    }
    if (updateAt != null) {
      data['updateAt'] = updateAt.toString();
    }
    data['id_usuario'] = userId;
    return data;
  }

  NewsModel copyWith({String? title, String? description}) {
    return NewsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      updateAt: updateAt,
      userId: userId,
    );
  }
}
