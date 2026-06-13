import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snippet_saver/controllers/text_controllers.dart';

import 'package:snippet_saver/custom_classes/snipp.dart';
import 'package:snippet_saver/models/snippet.dart';
import 'package:snippet_saver/providers/hive_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isCopied = false;
  bool hasHovered = false;
 String searchQuery = "";
  void showBox(BuildContext context){
    showDialog(context: context, 
    builder: (BuildContext dialogContext){
      return AlertDialog(
        title: Text(
          "Create new snippet"
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Colors.transparent,
        title: Text(
          "Snippetify",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Bits",
          //  fontWeight: FontWeight.bold,
            fontSize: 32
          ),
        ),
        actions: [
       
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
       
      child: SizedBox(
           width: 400,   
        child: Container(
   
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color:  Color.fromARGB(255, 25, 25, 112)
        ),
        child: TextField(
        
          controller: searchController,
          onChanged: (value){
            setState(() {
              searchQuery = value.toLowerCase();
            });
          },

          style: TextStyle(
            color: Colors.white,
            fontFamily: "Garamound",
            fontSize: 20
          ),
        decoration: InputDecoration(
        suffix:
          
     IconButton(
          onPressed: (){
            searchController.clear();
          } ,
           icon: Icon(
            Icons.cancel,color: Colors.white,
           ))
         ,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Text("Search snippet", style: TextStyle(color: const Color.fromARGB(87, 255, 255, 255)),),         
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white70
          )
        ),
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black
            )
          ),
        ),
        ),
        
      ),
            // InputField(controller: searchController , label: "Search snippet", minLines: 1),
        
      ))
        ],
      ),
      backgroundColor:  Color(0xFF0A1128),
      body: Padding(padding: EdgeInsetsGeometry.all(8.0),
      child: Row(
        children: [
          Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color.fromARGB(255, 25, 25, 112)
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                   IconButton(onPressed: (){
          },
           icon: 
           Icon(
      Icons.settings,color: Colors.white,
           size: 32,
           )),
  const SizedBox(height: 24,),
              IconButton(onPressed: (){
                Navigator.popAndPushNamed(context, "/newSnippetPage");
          },
           icon: Icon(
               size: 32,
            Icons.add,color: Colors.white,)),
              ],
            )
            ),
          
          SizedBox(width: 16,),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Snippet>(snippetBox).listenable(),
              builder: (context, Box<Snippet> box, child) {
              final snippets = box.values.toList();
              final filteredSnippets = snippets.where((snippet){
                if (searchQuery.isEmpty){
                  return true;
                }
              final titleMatch = snippet.title!.toLowerCase().contains(searchQuery);
              final codeMatch = snippet.code!.toLowerCase().contains(searchQuery);
              return titleMatch || codeMatch ;
              }).toList();
                return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                    
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.5
                ),
                itemCount: filteredSnippets.length,
                itemBuilder: (context,index){
                  final Snippet snippet = filteredSnippets[index];
                return Snipp(snippet: snippet );
              
                //  return snippetL(context,  snippet, style, isCopied, hasHovered);
                  
                });
              }
            ),
          ),
        ],
      ),
      ));
    
  }

  GestureDetector snippetL(
    BuildContext context, Snippet snippet, TextStyle style, bool copied, bool isHovered  ) {
    return GestureDetector(
                  onTap: (){
                    Navigator.popAndPushNamed(context, "/detailsPage", arguments: snippet);
                     
                  },
            //Mouse region was used to perform actions based on mouse gestures                    
                  child: MouseRegion(
                    onEnter: (event) {
                      setState(() {
                        isHovered = true;
                      }
                      );
                    
                    },
                    onExit: (event) {
                      setState(() {
                        isHovered = false;
                      });
                    },
                    //For makaing the container animatable
                    child: AnimatedContainer(
                      duration: Duration(
                        milliseconds: 400
                      ),
                           padding: EdgeInsets.all(8.0),
                         decoration: BoxDecoration(
                          
                        color: isHovered ? Color.fromARGB(174, 45, 73, 145) : Color(0xFF131E3A),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 5),
                            blurRadius: 10
                          )
                        ]
                      ),
                      
                    // AnimatedContainer's content
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                               
                                  snippet.title ?? "",
                                  style: style,
                                ),
                                Spacer(),
                                Row(
                                  children: [
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
                                    IconButton(
                                      onPressed:(){
                                        snippet.delete();
                                      }, 
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                  ],
                                )
                              ],
                            ),
                             Divider(
                            thickness: 0.5,
                         //   color: Colors.blue,
                          ),
                         //   SizedBox(height: 8,),
                            Text(
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              snippet.description ?? "",
                           style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Garamound",
                            fontSize: 20
                           ),   
                            ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          Divider(
                            thickness: 0.5,
                          ),
                             Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 7 ,
                              snippet.code ?? "",
                              style: style,
                            ),
                              SizedBox(height: 8,),
                          ],
                        ),
                      ),
                  ),
                );
  }
}