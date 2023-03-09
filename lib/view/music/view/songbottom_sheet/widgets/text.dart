  import 'package:flutter/material.dart';

Widget bottomText(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }