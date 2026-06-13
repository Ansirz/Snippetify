import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snippet_saver/models/snippet.dart';
import 'package:snippet_saver/pages/details_page.dart';
import 'package:snippet_saver/pages/home_page.dart';
import 'package:snippet_saver/pages/new_snippet_page.dart';
import 'package:snippet_saver/providers/hive_box.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
    Hive.registerAdapter(SnippetAdapter());
  await Hive.openBox<Snippet>(snippetBox);

  
  runApp(
    MaterialApp(
      theme: ThemeData(
       
        
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/homePage": (context)=> HomePage(),
        "/newSnippetPage":(context) => NewSnippetPage(),
        "/detailsPage": (context) => DetailsPage()
      },
      home: HomePage(),
    )
  );
}