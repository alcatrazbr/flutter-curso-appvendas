import 'package:app_vendas/pages/HomePage.dart';
import 'package:app_vendas/pages/ItensLista.dart';

import 'package:app_vendas/pages/SobrePage.dart';
import 'package:app_vendas/pages/Produto-Add.dart';
import 'package:flutter/material.dart';

import 'layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    SobrePage.tag: (context) => SobrePage(),
    ItensLista.tag: (context) => ItensLista(),
    ProdutoAdd.tag: (context) => ProdutoAdd(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Vendas',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primaryColor: Layout.primary(),
        accentColor: Layout.secondary(),
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize:48,
            fontWeight: FontWeight.bold
          ),
          title: TextStyle(
              fontSize:24,
              fontStyle: FontStyle.italic,
              color: Layout.primary(),
          )
        )
      ),
      home: HomePage(),
      routes: routes
    );
  }
}