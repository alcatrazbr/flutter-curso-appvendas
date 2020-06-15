import 'package:curso_1/package/ListaVendas.dart';
import 'package:flutter/material.dart';
import 'package:curso_1/layout.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final content = Center(child: Text('Página'));
    final content = ListaVendas();    
    return Layout.getContent(context, content);
  }
}