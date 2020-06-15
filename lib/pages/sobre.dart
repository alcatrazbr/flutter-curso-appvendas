import 'package:flutter/material.dart';
import 'package:curso_1/layout.dart';

class SobrePage extends StatelessWidget {
  static String tag = 'Sobre';
  @override
  Widget build(BuildContext context) {
    return Layout.getContent(context, Center(
      child: Text('Página sobre'),
    ));
  }
}