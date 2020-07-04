import 'package:app_vendas/models/ProdutoModel.dart';
import 'package:app_vendas/pages/ItensLista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../application.dart';
import '../layout.dart';

class ListaProdutos extends StatefulWidget {

  final List<Map> items;
  final String filter;
  final ProdutosAdd produtosAdd;

  const ListaProdutos({Key key, this.items, this.filter, this.produtosAdd}) : super(key: key);

  @override
  _ListaProdutosState createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {

  @override
  Widget build(BuildContext context) {

    // Item default
    if (widget.items.isEmpty) {
      return ListView(
          shrinkWrap: true,
          children: <Widget>[
            ListTile(title: Text('Nenhum Produto para exibir ainda'))
          ]
      );
    }

    // The list after filter apply
    List<Map> filteredList = List<Map>();

    // There is some filter?
    if (widget.filter.isNotEmpty) {
      for (dynamic item in widget.items) {

        // Check if theres this filter in the current item
        String name = item['nome'].toString().toLowerCase();
        if (name.contains(widget.filter.toLowerCase())) {
          filteredList.add(item);
        }
      }
    } else {
      filteredList.addAll(widget.items);
    }

    // Empty after filters
    if (filteredList.isEmpty) {
      return ListView(
          shrinkWrap: true,
          children: <Widget>[
            ListTile(title: Text('Nenhum produto encontrado...'))
          ]
      );
    }

    // Instancia model
    ModelProduto produto = ModelProduto();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int i) {

          Map item = filteredList[i];
          double realVal =currencyToDouble(item['valor']);
          String valTotal = doubleToCurrency(realVal * item['quantidade']);

          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.2,
            closeOnScroll: true,
            child: ListTile(
              leading: GestureDetector(
                child: Icon(
                    ((item['checked'] == 1) ? Icons.check_box : Icons.check_box_outline_blank),
                    color: ((item['checked'] == 0) ? Layout.dark(0.5) : Layout.secondary()),
                    size: 30
                ),
                onTap: () {
                  produto.update({ 'checked': !(item['checked'] == 1) }, item['pk_produto']).then((bool updated) {
                    if (updated) {
                      widget.produtosAdd.getList();
                    }
                  });
                },
              ),
              title: Text(item['nome']),
              subtitle: Text('${item['quantidade']} X ${item['valor']} = $valTotal'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                produto.getItem(item['pk_produto']).then((Map i) {

                  //abrir a pagina de edição

                });
              },
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Deletar',
                icon: Icons.delete,
                color: Colors.red,
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Text('Tem certeza?'),
                          content: Text('Esta ação irá remover o item selecionado e não poderá ser desfeita'),
                          actions: <Widget>[
                            RaisedButton(
                              color: Layout.secondary(),
                              child: Text('Cancelar', style: TextStyle(color: Layout.light())),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            RaisedButton(
                                color: Layout.danger(),
                                child: Text('Remover', style: TextStyle(color: Layout.light())),
                                onPressed: () {
                                  produto.delete(item['pk_produto']);

                                  Navigator.of(ctx).pop();
                                  widget.produtosAdd.getList();
                                }
                            )
                          ],
                        );
                      }
                  );
                },
              )
            ],
          );
        }
    );
  }
}