class AddReviewModel {
  int? post;
  int? rating;
  String? content;
  String? authorName;
  String? authorEmail;


  //<editor-fold desc="Data Methods">
  AddReviewModel({
    this.post,
    this.rating,
    this.content,
    this.authorName,
    this.authorEmail,

  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddReviewModel &&
          runtimeType == other.runtimeType &&
          post == other.post &&
          rating == other.rating &&
          content == other.content &&
          authorName == other.authorName &&
          authorEmail == other.authorEmail
          );

  @override
  int get hashCode =>
      post.hashCode ^
      rating.hashCode ^
      content.hashCode ^
      authorName.hashCode ^
      authorEmail.hashCode ;

  @override
  String toString() {
    return 'AddReviewModel{' +
        ' post: $post,' +
        ' rating: $rating,' +
        ' content: $content,' +
        ' authorName: $authorName,' +
        ' authorEmail: $authorEmail,' +

        '}';
  }

  AddReviewModel copyWith({
    int? post,
    int? rating,
    String? content,
    String? authorName,
    String? authorEmail,
    String? authorUrl,
  }) {
    return AddReviewModel(
      post: post ?? this.post,
      rating: rating ?? this.rating,
      content: content ?? this.content,
      authorName: authorName ?? this.authorName,
      authorEmail: authorEmail ?? this.authorEmail,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post': this.post,
      'rating': this.rating,
      'content': this.content,
      'author_name': this.authorName,
      'author_email': this.authorEmail,

    };
  }

  factory AddReviewModel.fromMap(Map<String, dynamic> map) {
    return AddReviewModel(
      post: map['post'] as int,
      rating: map['rating'] as int,
      content: map['content'] as String,
      authorName: map['author_name'] as String,
      authorEmail: map['author_email'] as String,

    );
  }

  //</editor-fold>
}