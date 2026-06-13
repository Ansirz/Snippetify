
import 'package:hive_flutter/hive_flutter.dart';
part 'snippet.g.dart';
@HiveType(typeId: 0)
class Snippet extends HiveObject  {



@HiveField(0)
 String? title;
@HiveField(1)
 String? description;
 @HiveField(2)
DateTime date;
@HiveField(3)
String? code;  
  Snippet({
  required this.code,
  required this.date,
  required this.description,
  required this.title
});

}