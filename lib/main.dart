import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//by": "dhouston",
//"descendants": 71,
//"id": 8863,
//"kids": [],
//"score": 104,
//"time": 1175714200,
//"title": "My YC app: Dropbox - Throw away your USB drive",
//"type": "story",
//"url":

class Post {
  String by;
  String descendants;
  int id;
  List kids;
  int score;
  int time;

  String title;
  String type;
  String url;

  Post(this.by, this.descendants, this.id, this.kids, this.score, this.time,
      this.title, this.type, this.url);
}

void main()  {
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Post post = Post("", "", 0, [], 0, 0, "", "", "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('New APP BAR!!'),
          backgroundColor: Colors.blueAccent,
        ),
        body: new FutureBuilder(

            future: _getJsonList(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {

                    return new FutureBuilder(
                        initialData: {
                          "by": "mkagenius",
                          "descendants": 29,
                          "id": 17385135,
                          "kids": [17385306],
                          "score": 165,
                          "time": 1529819124,
                          "title": "Dealing with Hard Problems",
                          "type": "story",
                          "url": "https://artofproblemsolving.com/articles/hard-problems"
                        },
                        future: _getData(snapshot.data[index]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot1) {
                          if (snapshot1.hasData) {
                            return ListTile(title: new Text('${snapshot1.data['title']}'),
                            trailing: new Text('${snapshot1.data['score']}'),
                              leading: new Text('score: ${snapshot1.data['score']}'),
                              

                            );
                          } else {
                            new Container();
                          }
                        });
                  },
                );
              } else {
                return new Container();
              }
            }));
  }

  Future<List> _getJsonList() async {
    try {
      http.Response response1 = await http
          .get('https://hacker-news.firebaseio.com/v0/topstories.json?');

      return json.decode(response1.body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map> _getData(int postingId) async {
    try {
      if (postingId != null) {
        http.Response response = await http.get(
            'https://hacker-news.firebaseio.com/v0/item/${postingId}.json?');
        print('from JsoN: ${json.decode(response.body)}');

        return json.decode(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
