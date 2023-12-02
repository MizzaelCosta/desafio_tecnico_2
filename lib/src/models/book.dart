// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.downloadUrl,
    this.epub,
    required this.favorite,
  });

  final int id;
  final String title;
  final String author;
  final String imageUrl;
  final String downloadUrl;
  final dynamic epub;
  final bool favorite;

  factory Book.empty() {
    return const Book(
      id: 0,
      title: '',
      author: '',
      imageUrl: '',
      downloadUrl: '',
      epub: null,
      favorite: false,
    );
  }

  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? imageUrl,
    String? downloadUrl,
    dynamic epub,
    bool? favorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      epub: epub ?? this.epub,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'downloadUrl': downloadUrl,
      'epub': epub,
      'favorite': favorite,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      imageUrl: map['cover_url'] as String,
      downloadUrl: map['download_url'] as String,
      epub: map['epub'] as dynamic,
      favorite: map['favorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, imageUrl: $imageUrl, downloadUrl: $downloadUrl, epub: $epub, favorite: $favorite)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.author == author &&
        other.imageUrl == imageUrl &&
        other.downloadUrl == downloadUrl &&
        other.epub == epub &&
        other.favorite == favorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        imageUrl.hashCode ^
        downloadUrl.hashCode ^
        epub.hashCode ^
        favorite.hashCode;
  }
}
