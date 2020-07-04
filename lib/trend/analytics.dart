import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;

class GetRssFeed extends StatefulWidget {
  @override
  _GetRssFeedState createState() => _GetRssFeedState();
}

class _GetRssFeedState extends State<GetRssFeed> {
  static String rssUrl =
      'https://trends.google.com/trends/trendingsearches/daily/rss?geo=IN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODAY\'S TRENDING TAGS IN INDIA',
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF212128),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        child: FutureBuilder(
          future: fetchNews(),
          builder: (context, snap) {
            if (snap.hasData) {
              final List _news = snap.data;
              return ListView.separated(
                itemBuilder: (context, i) {
                  final NewsModel _item = _news[i];
                  return ListTile(
                    title: Text(
                      '${i + 1}' '. ' '${_item.title}',
                      style: titleFeed,
                    ),
                  );
                },
                separatorBuilder: (context, i) => Divider(),
                itemCount: _news.length,
              );
            } else if (snap.hasError) {
              return Center(
                child: Text(
                  'CHECK YOUR INTERNET CONNECTION AND RELOAD',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future fetchNews() async {
    final _response = await http.get(rssUrl);

    if (_response.statusCode == 200) {
      var _decoded = new RssFeed.parse(_response.body);
      return _decoded.items
          .map((item) => NewsModel(
                title: item.title,
              ))
          .toList();
    } else {
      throw HttpException('Failed to fetch the data');
    }
  }
}

class NewsModel {
  final String title;
  NewsModel({this.title});
}

TextStyle titleFeed = new TextStyle(
    fontFamily: "Avenir",
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontSize: 25);
