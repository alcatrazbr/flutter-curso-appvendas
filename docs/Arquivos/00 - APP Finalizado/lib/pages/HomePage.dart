import 'package:app_vendas/models/VendaModel.dart';
import 'package:app_vendas/widgets/ListaVendas.dart';
import 'package:flutter/material.dart';

import '../layout.dart';
import 'ItensLista.dart';


class HomePage extends StatefulWidget {

  static String tag = 'home-page';

  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ModelVenda venda = ModelVenda();
    final content = FutureBuilder(
        future: venda.list(),
        builder:(BuildContext context, AsyncSnapshot snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: Text('Carregando...'));
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return ListaVendas(
                  itens: snapshot.data,
                );
              }
          }
    });
    return Layout.getContent(context, content);
  }

  }
