import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'note.dart';
import 'db.dart';
import 'notetitle.dart';
import 'notescreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212128),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0))),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: FutureBuilder(
            future: Database.instance.getAllNotes(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
              if (snapshot.hasData) {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    child: NoteTile(note: snapshot.data[index]),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteScreen(note: snapshot.data[index]),
                        ),
                      );
                    },
                  ),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              } else {
                return Center(
                  child: Text(
                    'ADD NOTE',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Database.instance.createNote();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(note: note),
            ),
          );
        },
        tooltip: 'Add note',
        child: Icon(Icons.add),
      ),
    );
  }
}
