import 'package:blog_app/entities/author.dart';
import 'package:blog_app/view_blog.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'entities/blog.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Blog simple app',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'All Blogs '),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Blogs>> _getBlogs() async {
    var data = await http.get(
        "https://raw.githubusercontent.com/Muhaiminur/muhaiminur.github.io/master/misfitflutter.tech");

    var jsonData = json.decode(data.body);

    List<Blogs> blogs = [];

    for (var u in jsonData['blogs']) {
      List<String> tmp_category = [];

      for (var c in u['categories']) {
        tmp_category.add(c);
      }

      Author author = Author(u['author']['id'], u['author']['name'],
          u['author']['avatar'], u['author']['profession']);

      Blogs blog = Blogs(u["id"], u["title"], u["description"],
          u["cover_photo"], author, tmp_category);
      blogs.add(blog);
    }

    return blogs;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getBlogs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Card(
                      elevation: 10,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  child: Image(
                                    image: NetworkImage(
                                        snapshot.data[index].cover_photo),
                                    fit: BoxFit.cover,
                                    height: 100,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                )),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          snapshot.data[index].title,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          snapshot.data[index].description,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 4,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => view_blog(
                              blog: snapshot.data[index],
                            ),
                          ));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Blogs blogs;

  DetailPage(this.blogs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(blogs.title),
    ));
  }
}
