class GoogleSearchModel {
  final String link;
  final String title;

  GoogleSearchModel({
    this.link = '',
    this.title = '',
  });

  GoogleSearchModel copyWith({
    String? link,
    String? title,
  }) {
    return GoogleSearchModel(
      link: link ?? this.link,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
      'title': title,
    };
  }

  factory GoogleSearchModel.fromMap(Map<String, dynamic> map) {
    return GoogleSearchModel(
      link: map['link'] as String,
      title: map['title'] as String,
    );
  }

  @override
  bool operator ==(covariant GoogleSearchModel other) {
    if (identical(this, other)) return true;

    return other.link == link && other.title == title;
  }

  @override
  int get hashCode => link.hashCode ^ title.hashCode;
}
