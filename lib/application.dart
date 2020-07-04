String dbName = 'vendas.db';
int dbVersion = 1;
List<String> dbCreate = [
  """
  CREATE TABLE venda (
    idVenda INTEGER PRIMARY KEY,
    Cliente TEXT,
    dtVenda TEXT,    
  )
  """,
  """
  CREATE TABLE PRODUTO (    
    idProduto INTEGER PRIMARY KEY,
    idVenda INTEGER,
    Descricao TEXT,
    Qtd INTEGER,    
    Valor DECIMAL(10,2),    
  )
  """
];