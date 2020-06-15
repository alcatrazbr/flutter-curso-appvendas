import 'package:curso_1/pages/ItemsLista.dart';
import 'package:flutter/material.dart';

import '../layout.dart';

class ListaVendas extends StatefulWidget {
  
  static List<Widget>items = List<Widget>();

  @override
  _ListaVendasState createState() => _ListaVendasState();
}

class _ListaVendasState extends State<ListaVendas> {
  @override
  Widget build(BuildContext context) {

   List<Widget>valores = List<Widget>();

    if (ListaVendas.items.length < 1) {
      valores.add(
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Nenhum ítem adicionado'),
            onTap: (){
              Navigator.of(context).pushNamed(ItemsLista.tag);
            },
          )        
      );
    }

    return ListView(
      shrinkWrap: true,
      children: (ListaVendas.items.length < 1)?valores:ListaVendas.items,
    );
    // return Layout.getContent(context, content);
  }
}