import 'package:app_vendas/models/ProdutoModel.dart';
import 'package:app_vendas/pages/ItensLista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../application.dart';
import '../layout.dart';



class ProdutoAdd extends StatefulWidget {

  static String tag = 'produtos-add';

  @override
  _ProdutoAddState createState() => _ProdutoAddState();
}

class _ProdutoAddState extends State<ProdutoAdd> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cQtd = TextEditingController(text: '1');
  final MoneyMaskedTextController _cValor =MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: ',',
      leftSymbol: 'R\$ '
  );


  bool isSelected = false;

  @override
  Widget build(BuildContext context) {

    final inputName = TextFormField(
      controller: _cName,
      autofocus: true,
      decoration: InputDecoration(
          hintText: 'Nome do Produto',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          )
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    final inputQuantidade = TextFormField(
      controller: _cQtd,
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Quantidade',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          )
      ),

      validator: (value) {

        double valueAsDouble = (double.tryParse(value) ?? 0.0);

        if (valueAsDouble <= 0) {
          return 'Informe um número positivo';
        }
        return null;
      },
    );



    final inputValor = TextFormField(
      controller: _cValor,
      autofocus: false,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          hintText: 'Valor R\$',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          )
      ),
      validator: (value) {
        if (currencyToDouble(value) < 0.0) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    Container content = Container(
        child: Form(
          key: _formKey,
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text(
                  'Adicionar Produto',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),
                ),
                SizedBox(height: 10),
                Text('Nome do Produto'),
                inputName,
                SizedBox(height: 10),
                Text('Quantidade'),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: inputQuantidade,
                      ),

                    ]
                ),
                SizedBox(height: 10),
                Text('Valor'),
                inputValor,
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      activeColor: Layout.primary(),
                      onChanged: (bool value) {
                        setState(() {
                          this.isSelected = value;
                        });
                      },
                      value: this.isSelected,
                    ),
                    GestureDetector(
                      child: Text('Já está Adicionado?', style: TextStyle(fontSize: 18)),
                      onTap: () {
                        setState(() {
                          this.isSelected = !this.isSelected;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(height: 50),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Layout.dark(0.2),
                        child: Text('Cancelar', style:TextStyle(color: Layout.light())),
                        padding: EdgeInsets.only(left: 50, right: 50),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      RaisedButton(
                        color: Layout.primary(),
                        child: Text('Salvar', style:TextStyle(color: Layout.light())),
                        padding: EdgeInsets.only(left: 50, right: 50),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {

                            // Instancia model
                            ModelProduto produto = ModelProduto();

                            // Adiciona no banco de dados
                            produto.insert({
                              'fk_venda  ': ItensLista.pkVenda,
                              'nome': _cName.text,
                              'quantidade': _cQtd.text,

                              'valor': _cValor.text,
                              'checked': this.isSelected,
                              'data': DateTime.now().toString()
                            }).then((saved) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(ItensLista.tag);

                            });
                          }
                        },
                      )
                    ])
              ]
          ),
        )
    );

    return Layout.getContent(context, content, false);
  }
}