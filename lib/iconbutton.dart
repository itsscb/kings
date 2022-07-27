import 'package:flutter/material.dart';

Widget icoBtn(
    IconData i,
    Function() onTap,
    bool show,
    ) {
  return Expanded(
    child: IconButton(
      iconSize: 50,
      onPressed: onTap,
      icon: Icon(
        i,
        color: show ? Colors.white : const Color.fromARGB(0, 0, 0, 0),
      ),
    ),
  );
}
