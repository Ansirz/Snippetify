import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippet_saver/models/snippet.dart';
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool copied = false;
  @override
  Widget build(BuildContext context) {
  
      final snippet = ModalRoute.of(context)?.settings.arguments as Snippet;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        onPressed: (){
          Navigator.popAndPushNamed(context, "/homePage");

        },
         icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
         )),
        backgroundColor: Color.fromARGB(139, 25, 25, 112),
      ),
        backgroundColor:  Color(0xFF0A1128),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  snippet.title ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Bits",
                    fontSize: 32
                  ),
                ),
                  IconButton(onPressed: () {
                                      Clipboard.setData(ClipboardData(text: snippet.code ?? "")).then(
                        (_){
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                          
                            SnackBar(
                              duration: Duration(
                                milliseconds: 800
                              ),
                              behavior: SnackBarBehavior.floating,
                              width: 100,
                       backgroundColor:  Color.fromARGB(255, 25, 25, 112) ,

                              content: Text(
                                textAlign: TextAlign.center,
                               "Copied",
                               style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Bits"
                               ), 
                              )
                            
                            )
                          );
                          setState(() {
                            copied = true;
                          });
                        }
                                      );
                                    },
                                     icon:Icon( copied ? Icons.check : Icons.copy,
                                     color: Colors.green,
                                     )),
              ],
            ),
            Text(
              "${snippet.date.year}/${snippet.date.month.toString().padLeft(2, "0")}/${snippet.date.day.toString().padLeft(2, "0")}",
              style: TextStyle(
                color: Colors.white
              ),

            ),
            SizedBox(height: 24.0,),
            Text(
              snippet.description ?? "",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Garamound",
                fontSize: 24
              ),
            ),
              SizedBox(height: 40.0,),
               Text(
              snippet.code ?? "",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Garamound",
                fontSize: 24
              ),
            ),
          ],
        ),
      ),
    );
  }
}