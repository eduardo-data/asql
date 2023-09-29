-- Databricks notebook source
SELECT count(*)
FROM silver.olist.vendedor
WHERE descUF = 'RJ'

-- COMMAND ----------

SELECT *
FROM silver.olist.vendedor

-- COMMAND ----------

SELECT descUF,
       count(DISTINCT idVendedor) as qtdVendedores -- distinct para nao repetir 
FROM silver.olist.vendedor
GROUP BY descUF -- aqui temos o groupby 
ORDER BY descUF

-- COMMAND ----------

-- avg -  quais os 10 produtos que tem maior peso medio?
SELECT descCategoria,
       avg(vlPesoGramas) as avgPesoCategoria,
       count(idProduto) -- aqui nao precisa do distinct pois sao 10 produtos ja definido
FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY avgPesoCategoria DESC

LIMIT 10 -- aqui usamos o limit 
