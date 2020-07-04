import 'dart:io';
import 'package:flutter/services.dart';
import 'note.dart';
import 'dbutils.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart' as sqflite;

class Database {
  Database._();
  static Database _instance;
  static Database get instance {
    if (_instance == null) {
      _instance = Database._();
    }
    return _instance;
  }

  sqflite.Database _database;
  Future init() async {
    final defaultDatabasePath = await getDatabasesPath();
    final databasePath =
        path.join(defaultDatabasePath, DatabaseUtils.notesDatabaseFilename);
    bool databaseAlreadyCreated = await databaseExists(databasePath);
    if (!databaseAlreadyCreated) {
      await _createDatabase(databasePath);
    }
    _database = await openDatabase(databasePath);
  }

  Future _createDatabase(String databasePath) async {
    ByteData data =
        await rootBundle.load(DatabaseUtils.notesDatabaseAssetTemplatePath);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(databasePath).writeAsBytes(bytes);
  }

  Future<Note> createNote({String title = '', String contents = ''}) async {
    int id = await _insertNote(title, contents);
    return getNote(id: id);
  }

  Future<int> _insertNote(String title, String contents) {
    return _database
        .rawInsert(DatabaseUtils.queryInsertNote, [title, contents]);
  }

  Future updateNote(Note note) async {
    _database.rawUpdate(
        DatabaseUtils.queryUpdateNote, [note.title, note.contents, note.id]);
  }

  Future deleteNote(Note note) async {
    _database.rawUpdate(DatabaseUtils.queryDeleteNote, [note.id]);
  }

  Future<Note> getNote({int id}) async {
    List<Map> results =
        await _database.rawQuery(DatabaseUtils.querySelectNote, [id]);
    return Note.fromJson(results.first);
  }

  Future<List<Note>> getAllNotes() async {
    List<Map> list =
        await _database.rawQuery(DatabaseUtils.querySelectAllNotes);
    return list.map((x) => Note.fromJson(x)).toList();
  }
}
