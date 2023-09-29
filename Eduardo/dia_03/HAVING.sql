-- Databricks notebook source
SELECT 
      date(dtPedido) AS diaPedido

FROM silver.olist.produto

-- COMMAND ----------

--visualização

SELECT descCategoria,
       count(idProduto) AS qtddeProduto,
       avg(vlPesoGramas) AS avgPeso,
       avg(vlAlturaCm * vlComprimentoCm * vlLarguraCm) as avgVolume

FROM silver.olist.produto

GROUP BY descCategoria
ORDER BY qtddeProduto DESC

limit 19 -- clica no mais abaixo e teremos um grafico

-- COMMAND ----------

-- having

SELECT descCategoria,
       count(idProduto) AS qtddeProduto,
       avg(vlPesoGramas) AS avgPeso,
       avg(vlAlturaCm * vlComprimentoCm * vlLarguraCm) as avgVolume

FROM silver.olist.produto

GROUP BY descCategoria
HAVING qtddeProduto >=500 -- filtro de pleo menos 500, aqui ja da as 19 linhas

ORDER BY qtddeProduto DESC
