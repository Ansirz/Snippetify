import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippet_saver/models/snippet.dart';
// ignore: must_be_immutable
class Snipp extends StatefulWidget {
final Snippet snippet;

  const Snipp({
    super.key,
 required this.snippet
    });

    @override
  State<Snipp> createState() {
    return _SnippState();
  }
}

class _SnippState extends State<Snipp> {
    bool copied =false;
    bool isHovered = false;
 

  @override
  Widget build(BuildContext context) {
  final style =TextStyle(
                    color: Colors.white,
//                    letterSpacing: 1.5,
                    fontSize: 18,
                    fontFamily: "Garamound"
                  );
    return GestureDetector(
                  onTap: (){
                    Navigator.popAndPushNamed(context, "/detailsPage", arguments: widget.snippet);
                     
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
                               
                                 widget.snippet.title ?? "",
                                  style: TextStyle(
                    color: Colors.white,
//                    letterSpacing: 1.5,
                    fontSize: 18,
                    fontFamily: "Bits"
                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    IconButton(onPressed: () {
                                      Clipboard.setData(ClipboardData(text: widget.snippet.code ?? "")).then(
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
                                        widget.snippet.delete();
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
                              widget.snippet.description ?? "",
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
                              widget.snippet.code ?? "",
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