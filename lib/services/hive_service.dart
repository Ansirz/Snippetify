import 'package:hive_flutter/adapters.dart';
import 'package:snippet_saver/models/snippet.dart';
import 'package:snippet_saver/providers/hive_box.dart';

class HiveService {
  void saveNewSnippet(String? title,String? description, DateTime date,String? code ) {
    final box = Hive.box<Snippet>(snippetBox);
    box.add(Snippet(code: code, date: date, description: description, title: title));

  }
  Future<void> clearAllSnippets() async{
    final box = Hive.box<Snippet>(snippetBox);
    await box.clear();
  }

}