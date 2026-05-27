drop database if exists Estoque_Comercial;
CREATE DATABASE Estoque_Comercial;
USE Estoque_Comercial;

CREATE TABLE itensestoque(
iditem INT NOT NULL AUTO_INCREMENT,
descricaoitem VARCHAR(200),
setoritem VARCHAR(200),
precoVendaitem DOUBLE(9,2),
estoqueitem INT,
PRIMARY KEY (iditem)
);

INSERT INTO itensestoque
(descricaoitem,setoritem,precoVendaitem,estoqueitem)VALUES
('Suco de Laranja','Bebidas','7.50',250),
('Macarrão 1kg','Alimentos','5.20',180),
('Sabão em pó','Limpeza','12.90',90),
('Café Torrado','Alimentos','15.80',120),
('Iogurte Natural','Laticínios','4.30',350),
('Biscoito Integral',NULL,'3.90',210),
('Molho de Tomate','Alimentos','2.80',500);



SELECT*FROM itensEstoque
WHERE precoVendaitem = (
SELECT MAX(precoVendaitem)
FROM itensestoque
);

SELECT*FROM itensestoque
WHERE precoVendaitem <> (
SELECT MAX(precoVendaitem)
FROM itensestoque
);

SELECT*FROM itensestoque
WHERE precoVendaitem <> 10; (
SELECT MAX(precoVendaitem)
FROM itensestoque
);

SELECT descricaoitem
FROM itensestoque
WHERE iditem IN (
SELECT iditem 
FROM itensestoque
WHERE precoVendaitem <> 2
);

select