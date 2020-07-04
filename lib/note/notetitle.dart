import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'note.dart';
import 'color.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  const NoteTile({@required this.note, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if (note.title.isNotEmpty)
              Text(
                note.title,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.title,
              ),
            if (note.title.isNotEmpty && note.contents.isNotEmpty)
              Container(height: 12),
            if (note.contents.isNotEmpty)
              Text(
                note.contents,
                style: Theme.of(context).textTheme.subhead,
              ),
          ],
        ),
      ),
    );
  }
}
