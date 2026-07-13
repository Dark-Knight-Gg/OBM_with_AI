class SplashModel {
  final int? id;
  final String? title;

  SplashModel({this.id, this.title});

  factory SplashModel.fromJson(Map<String, dynamic> json) => SplashModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (title != null) 'title': title,
      };
}
