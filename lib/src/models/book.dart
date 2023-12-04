// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.cover_url,
    required this.download_url,
    this.epub,
    required this.favorite,
  });

  final int id;
  final String title;
  final String author;
  final String cover_url;
  final String download_url;
  final dynamic epub;
  final bool favorite;

  factory Book.empty() {
    return const Book(
      id: 0,
      title: '',
      author: '',
      cover_url: '',
      download_url: '',
      epub: null,
      favorite: false,
    );
  }

  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? cover_url,
    String? download_url,
    dynamic epub,
    bool? favorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      cover_url: cover_url ?? this.cover_url,
      download_url: download_url ?? this.download_url,
      epub: epub ?? this.epub,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'cover_url': cover_url,
      'download_url': download_url,
      'epub': epub,
      'favorite': favorite,
    };
  }

  factory Book.fromMap(Map<dynamic, dynamic> map) {
    return Book(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      cover_url: map['cover_url'] as String,
      download_url: map['download_url'] as String,
      epub: map['epub'] as dynamic,
      favorite: map['favorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, cover_url: $cover_url, download_url: $download_url, epub: $epub, favorite: $favorite)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.author == author &&
        other.cover_url == cover_url &&
        other.download_url == download_url &&
        other.epub == epub &&
        other.favorite == favorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        cover_url.hashCode ^
        download_url.hashCode ^
        epub.hashCode ^
        favorite.hashCode;
  }
}
