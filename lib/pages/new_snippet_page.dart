import 'package:flutter/material.dart';
import 'package:snippet_saver/controllers/text_controllers.dart';
import 'package:snippet_saver/custom_classes/input_field.dart';
import 'package:snippet_saver/services/hive_service.dart';
class NewSnippetPage extends StatefulWidget {
  const NewSnippetPage({super.key});

  @override
  State<NewSnippetPage> createState() => _NewSnippetPageState();
}

class _NewSnippetPageState extends State<NewSnippetPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Color(0xFF0A1128),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: 600,
              height: 500,
              decoration: BoxDecoration(
                color:  Color.fromARGB(139, 25, 25, 112),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Create Snippet",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.0,
                      color: Colors.white,
                      fontFamily: "Garamound"
                    ),
                  ),
                  Spacer(),
                  IconButton(
                  onPressed: (){
                    Navigator.popAndPushNamed(context, "/homePage");
                  },
                   icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                   ))
                ],
              ),
              SizedBox(height: 32.0,),
              InputField(controller: titleController, label: "Title", minLines: 1,),
              SizedBox(height:  24.0),
              InputField(controller: descriptionController, label: "Description", minLines: 2,),
              SizedBox(height:  24.0),
              InputField(controller: codeController, label: "Code", minLines: 10,),
                SizedBox(height:  24.0),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(24.0),
                    backgroundColor: Color.fromARGB(255, 2, 2, 253),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12.0)
                    )
                  ),
                  onPressed: (){
                    HiveService().saveNewSnippet(
                      titleController.text.trim().toUpperCase(),
                     descriptionController.text.trim(),
                     DateTime.now(),
                     codeController.text.trim());
                     titleController.text ="";
                     descriptionController.text ="";
                     codeController.text = "";
                     Navigator.popAndPushNamed(context, "/homePage");
                  },
                   child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                   )),
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}