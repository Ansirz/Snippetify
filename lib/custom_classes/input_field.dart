import 'package:flutter/material.dart';
class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? minLines;
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.minLines
    });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
   
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color:  Color.fromARGB(255, 25, 25, 112)
        ),
        child: TextFormField(
          controller: controller,
     minLines: minLines,
     maxLines: 10,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Garamound",
            fontSize: 20
          ),
        decoration: InputDecoration(
        
          floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Text(label, style: TextStyle(color: const Color.fromARGB(87, 255, 255, 255)),),         
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
    );
  }
}