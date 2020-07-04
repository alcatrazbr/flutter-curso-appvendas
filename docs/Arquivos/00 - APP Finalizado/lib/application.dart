import 'package:intl/intl.dart';

String dbName = 'vendas.db';
int dbVersion = 1;

List<String> dbCreate = [
  //tabela de vendas
  """
  CREATE TABLE vendas(
    pk_venda INTEGER PRIMARY KEY,
    cliente TEXT,
    data TEXT
  )
  """,
  //FALTAVA A VIRGULA
  //

  //tabela de produtos
      """
  CREATE TABLE produtos(
    pk_produto INTEGER PRIMARY KEY,
    fk_venda INTEGER,
    nome TEXT,
    quantidade INTEGER,
    valor DECIMAL(10, 2),
    checked INTEGER DEFAULT 0,
    data TEXT
  )
  """
];


double currencyToDouble(String value) {
  value = value.replaceFirst('R\$ ', '');
  value = value.replaceAll(RegExp(r'\.'), '');
  value = value.replaceAll(RegExp(r'\,'), '.');

  return double.tryParse(value) ?? null;
}

double currencyToFloat(String value) {
  return currencyToDouble(value);
}

String doubleToCurrency(double value) {
  NumberFormat nf = NumberFormat.compactCurrency(locale: 'pt_BR', symbol: 'R\$');
  return nf.format(value);
}