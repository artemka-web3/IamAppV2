import 'package:flutter/material.dart';

void showInputSnackBar(String attention, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            attention,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
  );
}
