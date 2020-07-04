import 'package:app_vendas/models/VendaModel.dart';
import 'package:app_vendas/pages/HomePage.dart';
import 'package:app_vendas/pages/ItensLista.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../layout.dart';


enum ListAction{edit, delete}

class ListaVendas extends StatefulWidget {

  final List<Map>itens;
  ListaVendas({this.itens}) : super();

   @override
  ListaVendasState createState() {
    return new ListaVendasState();
  }
}

class ListaVendasState extends State<ListaVendas> {

  ModelVenda venda = ModelVenda();
  List<Widget> values = List<Widget>();

  @override
  Widget build(BuildContext context) {

    List<Widget>valores = List<Widget>();
    if(widget.itens.length == 0){
      return ListView(
        children: <Widget>[ListTile(
          leading: Icon(Icons.attach_money),
          title: Text('Nenhuma venda cadastrada ainda...'),
        )],
      );
    }

    DateFormat df = DateFormat('dd/MM/yy HH:mm');



    return ListView.builder(
        itemCount: widget.itens.length,
        itemBuilder: (BuildContext context, int index) {
          Map item = widget.itens[index];

          DateTime created = DateTime.tryParse(item['data']);

          return ListTile(
            leading: Icon(
            Icons.attach_money, size: 42, color: Layout.secondary(0.6)),
            title: Text(item['cliente']),
            subtitle: Text('(' + item['qtdProdutos'].toString() + ' Produtos) - ' +
                df.format(created)),

            trailing: PopupMenuButton<ListAction>(
             onSelected: (ListAction result) {
             switch(result) {
               case ListAction.edit:
                 showEditDialog(context, item);
                 break;
               case ListAction.delete:
                  venda.delete(item['pk_venda']).then((deleted){
                    if(deleted){
                      Navigator.of(context).pushReplacementNamed(HomePage.tag);
                    }
                  });
                 break;
             }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<ListAction>>[
                PopupMenuItem<ListAction>(
                  value: ListAction.edit,
                  child: Row(children: <Widget>[
                    Icon(Icons.edit, color: Layout.secondary()),
                    Text('Editar', style: TextStyle(color: Layout.secondary()))
                  ]),
                ),
                PopupMenuItem<ListAction>(
                  value: ListAction.delete,
                  child: Row(children: <Widget>[
                    Icon(Icons.delete, color: Layout.secondary()),
                    Text('Excluir', style: TextStyle(color: Layout.secondary()))
                  ]),
                ),
              ];
            }

          ),
            onTap:(){

              // Apontar na lista qual esta selecionada
              ItensLista.pkVenda = item['pk_venda'];
              ItensLista.cliente = item['cliente'];

              Navigator.of(context).pushNamed(ItensLista.tag);
            },

          );
        },
    );


  }



  void showEditDialog(BuildContext context, Map item) {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {

          TextEditingController _cEdit = TextEditingController();
          _cEdit.text = item['cliente'];

          final input = TextFormField(
            controller: _cEdit,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Nome',
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                )
            ),
          );

          return AlertDialog(
            title: Text('Editar'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  input
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Layout.dark(0.2),
                child: Text('Cancelar', style: TextStyle(color: Layout.light())),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              RaisedButton(
                color: Layout.primary(),
                child: Text('Salvar', style: TextStyle(color: Layout.light())),
                onPressed: () {
                  ModelVenda venda = ModelVenda();

                  venda.update({
                    'cliente': _cEdit.text,
                    'data': DateTime.now().toString()
                  }, item['pk_venda']).then((saved) {

                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pushReplacementNamed(HomePage.tag);

                  });
                },
              )
            ],
          );

        }
    );
  }

}
