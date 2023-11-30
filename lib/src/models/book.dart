// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.downloadUrl,
  });

  final int id;
  final String title;
  final String author;
  final String imageUrl;
  final String downloadUrl;

  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? imageUrl,
    String? downloadUrl,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'downloadUrl': downloadUrl,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      imageUrl: map['cover_url'] as String,
      downloadUrl: map['download_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, imageUrl: $imageUrl, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.author == author &&
        other.imageUrl == imageUrl &&
        other.downloadUrl == downloadUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        imageUrl.hashCode ^
        downloadUrl.hashCode;
  }
}
