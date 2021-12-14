
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import '../constant.dart';

Widget TextCostomField(
    String hintText, TextEditingController controller, double width) {
  return SizedBox(
    width: width,
    child: TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: hintTextColor,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      ),
    ),
  );
}

Widget creditCardTextField(
    String hintText, TextEditingController controller, double width) {
  return SizedBox(
    width: width,
    child: TextField(
      style:const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:const TextStyle(
          fontSize: 16,
          color: Colors.black12,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide:const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: colorWhite,
        contentPadding:const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      ),
    ),
  );
}

Widget buttonCostomField({String? text, VoidCallback? onTap, double? width})  {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 55,
      width: width,
      decoration: BoxDecoration(
        color: colorGreen,
        borderRadius:const BorderRadius.all(
          Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: colorGreen.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset:const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text!,
          style:const TextStyle(fontFamily:"Tajawal",wordSpacing: 1,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget userImageWidget(String _image, String _name) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          _image,
          height: 100.0,
          width: 100.0,
        ),
      ),
      const  SizedBox(
        height: 15,
      ),
      Text(
        _name,
        style:const TextStyle(fontFamily:"ReemKufi",fontSize: 25, color: Colors.black),
      ),
      const  SizedBox(
        height: 3,
      ),
    ],
  );
}
