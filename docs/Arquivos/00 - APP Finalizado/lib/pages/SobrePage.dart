import 'package:flutter/material.dart';

import '../layout.dart';

class SobrePage extends StatelessWidget {

  static String tag = 'sobre-page';

  @override
  Widget build(BuildContext context) {
    return Layout.getContent(context, Center(
      child:Text(
      'Página Sobre',
    ),
    ),
    );
  }
}