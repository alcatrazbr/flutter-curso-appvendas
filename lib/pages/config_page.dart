import 'package:flutter/material.dart';
import 'package:curso_1/layout.dart';

class ConfigPage extends StatefulWidget {
  static String tag = 'Config-Page';
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {    
    return Layout.getContent(context, Center(
      child: Text('!!! configurações !!!'),
    ));
  }
}