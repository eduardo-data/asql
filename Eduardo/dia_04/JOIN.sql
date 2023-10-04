-- Databricks notebook source
-- LEFT JOIN COM PRESIDENTE PRUDENTE E OS PEDIDOS DELES 

SELECT * 

FROM silver.olist.cliente

LEFT JOIN silver.olist.pedido
ON cliente.idCliente = pedido.idCliente

WHERE descCidade = "presidente prudente"

-- COMMAND ----------

-- LEFT JOIN com filtros

SELECT * 

FROM silver.olist.cliente

LEFT JOIN silver.olist.pedido
ON cliente.idCliente = pedido.idCliente -- posso usar apelidio se eu quiser 

WHERE year(dtPedido) = 2017
AND month((dtPedido)) = 11

-- COMMAND ----------

-- veremos os estados que mais venderam na black friday

SELECT cliente.descUF,
       count(DISTINCT pedido.idPedido) AS qtdePedido

FROM silver.olist.cliente

LEFT JOIN silver.olist.pedido
ON cliente.idCliente = pedido.idCliente -- posso usar apelidio se eu quiser 

WHERE year(dtPedido) = 2017
AND month((dtPedido)) = 11

GROUP BY cliente.descUF
ORDER BY qtdePedido DESC

-- COMMAND ----------

-- veremos os estados que mais venderam na black friday, teremos as datasA função date_trunc('month', t1.dtPedido) é usada para truncar a data de cada pedido para o primeiro dia do mês, resultando na coluna dtMesPedido, que representa o mês de cada pedido.

--A consulta tem como objetivo contar o número de pedidos distintos realizados no mês de novembro de 2017, agrupados por mês e estado (UF), exibindo o resultado em ordem decrescente de quantidade de pedidos.

--date_trunc ele apenas modifica a data para o dia 01º 

SELECT 
       date_trunc('month', t1.dtPedido) AS dtMesPedido,
       t2.descUF,
       count(DISTINCT t1.idPedido) AS qtdePedido

FROM silver.olist.pedido as t1

LEFT JOIN silver.olist.cliente as t2
ON t1.idCliente = t2.idCliente -- posso usar apelidio se eu quiser 

--WHERE year(dtPedido) = 2017
--nao precisa pois estamos usando o date_trunc AND month((dtPedido)) = 11

GROUP BY dtMesPedido,t2.descUF
ORDER BY qtdePedido DESC

-- fizemos o graico e barras e nao de linhas para vermos o total e ativamos o Stacking com stack

-- COMMAND ----------

-- QUAL ESTADO CONSOME MAIS PRODIUTO DE BB
-- PUXAMOS LOGO A TABELA ONDE OS FATOS OCORRERAM

SELECT  t1.idPedido, -- se eu quiser pegar todas as colunas da tabela 1 eu uso t1.* 
        t1.idProduto,
        t2.descCategoria,
        --t3.* -- todas as colunas da t3
        t3.idCliente,
        t4.descUF

FROM silver.olist.item_pedido AS t1

-- os left nao necessariamente ficam conectadas ao FROM e podemos ter mais de uma Join


LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

--faremos mais um left join

LEFT JOIN silver.olist.pedido AS t3
ON t1.idPedido = t3.idPedido


LEFT JOIN silver.olist.cliente AS t4
ON t3.idCliente = t4.idCliente -- na tabela t3 tem id cliente

WHERE t2.descCategoria = 'bebes'

-- COMMAND ----------

-- contagem dos pedidos 

SELECT
        t4.descUF ,
        count(DISTINCT t1.idPedido) AS qtdPedido,
        count(*) AS qtdeItemns
        

FROM silver.olist.item_pedido AS t1

-- os left nao necessariamente ficam conectadas ao FROM e podemos ter mais de uma Join


LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

--faremos mais um left join

LEFT JOIN silver.olist.pedido AS t3
ON t1.idPedido = t3.idPedido


LEFT JOIN silver.olist.cliente AS t4
ON t3.idCliente = t4.idCliente -- na tabela t3 tem id cliente

WHERE t2.descCategoria = 'bebes'

GROUP BY t4.descUF
HAVING count(DISTINCT t1.idPedido) > 10 -- pedidos com mais de 10

ORDER BY qtdPedido DESC

-- COMMAND ----------


