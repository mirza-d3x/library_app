class BookModel {
  final String title;
  final String author;
  final int publishedYear;
  final bool isRead;
  final String coverUrl;
  final String key;

  const BookModel({
    required this.title,
    required this.author,
    required this.publishedYear,
    this.isRead = false,
    required this.coverUrl,
    required this.key,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final work = json['work'];

    return BookModel(
      title: work['title'] ?? '',
      author:
          work['author_names'].isEmpty ? " " : work['author_names'][0] ?? '',
      publishedYear: work['first_publish_year'] ?? 0,
      isRead: false,
      coverUrl: work.containsKey('cover_id')
          ? 'https://covers.openlibrary.org/b/id/${work['cover_id']}-M.jpg'
          : '',
      key: work['key'] ?? '',
    );
  }

  factory BookModel.fromJsonSearch(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] ?? '',
      author: json['author_name'] != null
          ? json['author_name'].isEmpty
              ? " "
              : json['author_name'][0] ?? ''
          : "",
      publishedYear: json['first_publish_year'] ?? 0,
      isRead: false,
      coverUrl: json.containsKey('cover_i')
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
          : '',
      key: json['key'] ?? '',
    );
  }

  BookModel copyWith({
    String? title,
    String? author,
    int? publishedYear,
    bool? isRead,
    String? coverUrl,
    String? key,
  }) {
    return BookModel(
      title: title ?? this.title,
      author: author ?? this.author,
      publishedYear: publishedYear ?? this.publishedYear,
      isRead: isRead ?? this.isRead,
      coverUrl: coverUrl ?? this.coverUrl,
      key: key ?? this.key,
    );
  }

  static List<BookModel> listFromJson(Map<String, dynamic> json) {
    final List<dynamic> readingLogEntries = json['reading_log_entries'];
    return readingLogEntries
        .map<BookModel>((entry) => BookModel.fromJson(entry))
        .toList();
  }

  static List<BookModel> listFromJsonSearch(Map<String, dynamic> json) {
    final List<dynamic> readingLogEntries = json['docs'];
    return readingLogEntries
        .map<BookModel>((entry) => BookModel.fromJsonSearch(entry))
        .toList();
  }
}
