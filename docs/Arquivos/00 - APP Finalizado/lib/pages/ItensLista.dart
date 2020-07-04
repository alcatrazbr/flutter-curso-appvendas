import 'dart:async';

import 'package:app_vendas/models/ProdutoModel.dart';
import 'package:app_vendas/widgets/ListaProdutos.dart';
import 'package:flutter/material.dart';

import '../application.dart';
import '../layout.dart';
import 'Produto-Add.dart';

class ItensLista extends StatefulWidget {
  static String tag = 'itens-page';
  static int pkVenda;
  static String cliente;

  @override
  ItensListaState createState() {
    return new ItensListaState();
  }
}

class ItensListaState extends State<ItensLista> {

  final ProdutosAdd produtosAdd = ProdutosAdd();
  String filterText = "";

  @override
  void dispose() {
    produtosAdd.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final content = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(230, 230, 230, 0.5),
          padding: EdgeInsets.only(left: 15, top: 10),
          child: Text('Lista: '+ItensLista.cliente, style: TextStyle(
              fontSize: 16,
              color: Layout.dark()
          )),
        ),
        Container(
          color: Color.fromRGBO(230, 230, 230, 0.5),
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Pesquisar',
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        filterText = text;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Layout.secondary(),
                    onPressed: () {

                      // Abre tela para criar item de lista
                      Navigator.of(context).pushNamed(ProdutoAdd.tag);
                    },
                    child: Icon(Icons.add),
                  ),
                )
              ]
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Map>>(
            stream: produtosAdd.lists,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  case ConnectionState.waiting:
                  return const Center(child: Text('Carregando...'));
                  break; // Useless after return
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  } else {

                    return ListaProdutos(
                      items: snapshot.data,
                      filter: filterText,
                      produtosAdd: this.produtosAdd,
                    );

                  }
              }
            },
          ),
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              ),
              // color: Layout.secondary()
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Layout.secondary(0.2),
                    Layout.dark(0.4),
                  ]
              ),
            ),
            height: 80,
            child: StreamBuilder<List<Map>>(
              stream: produtosAdd.lists,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: Text('Carregando...'));
                    break; // Useless after return
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                    } else {

                      // Recupera os itens
                      List<Map> items = snapshot.data;

                      // Total de itens
                      int qtdTotal = items.length;

                      // Total de itens marcados
                      int qtdChecked = 0;

                      // Valor total quando todos os items estiverem marcados
                      double subTotal = 0.0;

                      // Valor total de items marcados
                      double vlrTotal = 0.0;

                      for (Map item in items) {

                        double vlr = currencyToFloat(item['valor']) * item['quantidade'];
                        subTotal += vlr;

                        if (item['checked'] == 1) {
                          qtdChecked++;
                          vlrTotal += vlr;
                        }
                      }

                      // Quando todos os items forem marcados
                      // o total devera ficar Verde (success)
                      bool isClosed = (subTotal == vlrTotal);

                      TextStyle secDarkText = TextStyle(color: Layout.primaryDark(), fontWeight: FontWeight.bold);

                      return Row(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(children: <Widget>[
                                Text('Produtos', style: secDarkText),
                                Text(qtdTotal.toString(), textScaleFactor: 1.0, style: secDarkText)
                              ]),
                              Column(children: <Widget>[
                                Text('Vendidos', style: secDarkText),
                                Text(qtdChecked.toString(), textScaleFactor: 1.0, style: secDarkText)
                              ]),

                            ],
                          ),
                        ),
                        Container(
                          color: Color.fromRGBO(0, 0, 0, 0.04),
                          width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Sub: '+doubleToCurrency(subTotal), style: TextStyle(
                                  fontSize: 17,
                                  color: Layout.secondaryDark(),
                                  fontWeight: FontWeight.bold
                              )),
                              SizedBox(height: 5),
                              Text('Total: '+doubleToCurrency(vlrTotal), style: TextStyle(
                                  fontSize: 21,
                                  color: isClosed ? Layout.primary() : Layout.secondaryDark(),
                                  fontWeight: FontWeight.bold
                              ))
                            ],
                          ),
                        )
                      ]);
                    }
                // End switch default option
                }
              },
            )
        )
      ],
    );

    return Layout.getContent(context, content, false);
  }
}


class ProdutosAdd {

  ProdutosAdd () {
    getList();
  }

  ModelProduto produto = ModelProduto();

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dispose() {
    _controller.close();
  }

  getList() async {
    _controller.sink.add(await produto.itemsByList(ItensLista.pkVenda));
  }
}
