import 'package:curso_1/layout.dart';
import 'package:curso_1/package/ListaVendas.dart';
import 'package:flutter/material.dart';

class ItemsLista extends StatefulWidget {
  static String tag = 'items-page';
  @override
  _ItemsListaState createState() => _ItemsListaState();
}

class _ItemsListaState extends State<ItemsLista> {
  static List<Widget> items = List<Widget>();

  @override
  void initState() {
    // TODO: implement initState
    _chamarLista();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // #region textedit
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              child: TextFormField(
                decoration: InputDecoration(hintText: "Pesquisar"),
              ),
            ),
          ),
          // #endregion
          // listview
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height - 200.0,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int idx) {
                return items[idx];
              },
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: Column(                
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: (){
                      print('chamando');
                      setState(() {
                        _chamarLista();
                      });
                    }
                  )
                ],
              )),
          // bottom ----------------------------------
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.blue,
                  padding: EdgeInsets.all(8.0),
                  height: 70.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Padding(padding: EdgeInsets.all(8)),
                      Text(
                        'Ítens adicionados: 1',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Total itens: 5',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.green,
                  padding: EdgeInsets.all(8.0),
                  height: 70.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                      Text('Total vendido: 10',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    return Layout.getContent(context, content, false);
  }

  void _chamarLista() {
    items.add(ListTile(
      leading: GestureDetector(
        child: Icon(
          Icons.check,
          color: Colors.grey,
        ),
        onTap: () {
          setState(() {});
          print('ok');
        },
      ),
      onLongPress: () {
        print('item');
      },
      title: Text('item'),
      trailing: GestureDetector(
        child: Icon(Icons.delete),
        onTap: () {
          print('delete');
        },
      ),
    ));
  }
}
