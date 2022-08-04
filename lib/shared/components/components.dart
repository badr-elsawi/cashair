import 'package:flutter/material.dart';

//text box **********************************************************************************
Widget textInput({
  required String label,
  required TextEditingController controller,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  bool obscureText = false,
  Color bColor = Colors.white,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
  required String errorMessage,
  Color errorColor = Colors.white,
  //Function? onTap,
  //Function? onChanged
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2,
          spreadRadius: 2,
        ),
      ],
    ),
    alignment: Alignment.center,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
//      onChanged: (String? value){
//        onChanged!(value!);
//      },
//      onTap: (){
//        onTap!();
//      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return errorMessage;
        }
      },
      cursorColor: Colors.deepOrangeAccent,
      maxLines: maxLines,
      //*********************************************
      decoration: InputDecoration(
        filled: true,
        fillColor: bColor,
        labelText: label,
        hoverColor: Colors.deepOrangeAccent,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusColor: Colors.deepOrangeAccent,
        errorStyle: TextStyle(
          color: errorColor,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.transparent,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 2)),
      ),
    ),
  );
}
//text box **********************************************************************************
