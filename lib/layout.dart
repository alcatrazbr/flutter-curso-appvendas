import 'package:curso_1/package/ListaVendas.dart';
import 'package:curso_1/pages/ItemsLista.dart';
import 'package:curso_1/pages/config_page.dart';
import 'package:curso_1/pages/home.dart';
import 'package:curso_1/pages/sobre.dart';
import 'package:flutter/material.dart';

class Layout {
  static int item = 0;
  static final pages = [
    HomePage.tag,
    SobrePage.tag,
    ConfigPage.tag,
  ];

  static TextEditingController txtCtrl = TextEditingController();

  static Scaffold getContent(BuildContext context, content, [bool menu = true]) {
    BottomNavigationBar bottomNavBar = BottomNavigationBar(
      currentIndex: item,
      //fixedColor: primary(),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.question_answer), title: Text('Sobre')),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text('Configurações'))
      ],
      onTap: (int i) {
        item = i;
        Navigator.of(context).pushReplacementNamed(pages[i]);
      },
    );

    if (!menu) {
      item = 1;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Layout.primary(),
        title: Text('Lista de Vendas'),
        // leading: Icon(Icons.menu),
        actions: _getActions(context),
      ),
      bottomNavigationBar: menu ? bottomNavBar : null,
      body: content,
    );
  }

  static List<Widget> _getActions(ctx) {
    List<Widget> items = List<Widget>();

  if (pages[item] != HomePage.tag) {
    return items;
  }


    items.add(
      GestureDetector(
        onTap: () {
          showDialog(
              context: ctx,
              barrierDismissible: false,
              builder: (BuildContext ctx) {
                final input = TextFormField(
                  controller: txtCtrl,
                  decoration: InputDecoration(
                      hintText: 'Produto',
                      contentPadding: (EdgeInsets.fromLTRB(20, 10, 20, 10))),
                );

                return AlertDialog(
                  title: Text('nome'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[input],
                    ),
                  ),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text('Adicionar'),
                      color: secondary(),
                      onPressed: () {
                        ListaVendas.items.add(
                          ListTile(
                            leading: Icon(Icons.attach_money),
                            title: Text(txtCtrl.text),
                            // subtitle: Text('sub'),
                            onTap: (){
                                Navigator.of(ctx).pushNamed(ItemsLista.tag);
                            },

                            trailing: Icon(Icons.more_vert),
                          )
                        );
                        // print(txtCtrl.text);

                        Navigator.of(ctx).popAndPushNamed(HomePage.tag);
                      },
                    ),
                    RaisedButton(
                      child: Text('Cancelar'),
                      color: secondary(),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );

    items.add(
         Padding(
            padding: EdgeInsets.all(8.0),
          ),      
    );
    return items;
  }

  static Color primary([double opacity = 1]) =>
      Colors.green[700].withOpacity(opacity);
  static Color primaryDark([double opacity = 1]) =>
      Color(0xff165a0c).withOpacity(opacity);
  static Color primaryLight([double opacity = 1]) =>
      Color(0xff6adf59).withOpacity(opacity);

  static Color secondary([double opacity = 1]) =>
      Colors.teal[700].withOpacity(opacity);
  static Color secondaryDark([double opacity = 1]) =>
      Color(0xff004c40).withOpacity(opacity);
  static Color secondaryLight([double opacity = 1]) =>
      Color(0xff48a999).withOpacity(opacity);

  static Color light([double opacity = 1]) =>
      Color.fromRGBO(242, 234, 228, opacity);
  static Color dark([double opacity = 1]) =>
      Color.fromRGBO(51, 51, 51, opacity);

  static Color danger([double opacity = 1]) =>
      Color.fromRGBO(217, 74, 74, opacity);
  static Color success([double opacity = 1]) =>
      Color.fromRGBO(5, 100, 50, opacity);
  static Color info([double opacity = 1]) =>
      Color.fromRGBO(100, 150, 255, opacity);
  static Color warning([double opacity = 1]) =>
      Color.fromRGBO(166, 134, 0, opacity);
}
