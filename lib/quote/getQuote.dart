import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/quote/Quote.dart';

class QuoteData extends StatefulWidget {
  @override
  _QuoteDataState createState() => _QuoteDataState();
}

Future<Quote> fetchQuote() async {
  final response = await http.get('https://favqs.com/api/qotd');
  if (response.statusCode == 200) {
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Quote');
  }
}

class _QuoteDataState extends State<QuoteData>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<Quote> quote;
  var dbHelper;
  Future<List<Quote>> wholeQuotes;
  @override
  void initState() {
    super.initState();
    quote = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xFF212128),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0))),
        child: FutureBuilder<Quote>(
          future: quote,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Quote For You',
                      style: quoteTitle,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        snapshot.data.quoteText,
                        style: textQuote,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      '-${snapshot.data.quoteAuthor}-',
                      style: textQuote,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "QUOTE LOADING FAILED DUE TO INTERNET ISSUES",
                      style: errorQuoteTitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

TextStyle textQuote = new TextStyle(
    fontFamily: "Avenir",
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20);
TextStyle quoteTitle = new TextStyle(
    fontFamily: "Avenir",
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    decoration: TextDecoration.underline,
    fontSize: 30);
TextStyle errorQuoteTitle = new TextStyle(
    fontFamily: "Avenir",
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    fontSize: 20);
