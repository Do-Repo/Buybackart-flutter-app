class Blog {
  int id;
  String title;
  String image;
  String author;
  String description;
  String created;

  Blog({
    required this.id,
    required this.title,
    required this.image,
    required this.author,
    required this.description,
    required this.created,
  });

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      created: map['created'] ?? '',
    );
  }
}
