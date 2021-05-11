import 'package:blog_app/entities/author.dart';

class Blogs {
  final int id;
  final String title;
  final String description;
  final String cover_photo;
  final List<String> categories;
  Author author;
  Blogs(this.id, this.title, this.description, this.cover_photo, this.author,
      this.categories);
}
