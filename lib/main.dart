import 'package:app/note/mainscreen.dart';
import 'package:app/note/db.dart';
import 'package:app/todo/todohome.dart';
import 'package:app/trend/analytics.dart';
import 'package:app/quote/getQuote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: new Scaffold(
            backgroundColor: Color(0xFF212128),
            body: TabBarView(
              children: [
                ToDoHomePage(),
                MainScreen(),
                QuoteData(),
                GetRssFeed()
              ],
            ),
            appBar: AppBar(
              title: Text(
                'HUSTLER\'S DEN',
                style: TextStyle(fontSize: 25),
              ),
              centerTitle: true,
              bottom: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.alarm_add),
                    text: 'TODO',
                  ),
                  Tab(icon: new Icon(Icons.book), text: 'NOTE'),
                  Tab(icon: new Icon(Icons.format_quote), text: 'QUOTE'),
                  Tab(icon: new Icon(Icons.assessment), text: 'TRENDING')
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.white,
                labelPadding: EdgeInsets.all(5.0),
              ),
              backgroundColor: Colors.red[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
