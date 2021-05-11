import 'package:blog_app/entities/author.dart';
import 'package:blog_app/entities/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class view_blog extends StatelessWidget {
  Blogs blog;
  String text = "Hasib Ahmed";

  // receive data from the FirstScreen as a parameter
  view_blog({Key key, @required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    String category = blog.categories.join(" ");

    String authorName = blog.author.name;
    String profession = blog.author.profession;
    String avatar = blog.author.avatar;

    return Scaffold(
        appBar: AppBar(title: Text('View Blog')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Image(
                  image: NetworkImage(blog.cover_photo),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: width * .9,
                child: Text(
                  blog.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: width * .9,
                child: Text(
                  blog.description,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: width * .9,
                child: Text(
                  "Category \n$category",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(bottom: 20),
                width: width * .9,
                child: Text(
                  "Author \nName:  $authorName",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
