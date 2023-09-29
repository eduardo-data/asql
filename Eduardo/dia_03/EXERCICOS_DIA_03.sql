-- Databricks notebook source
-- EXERCICIOS DO PDF DE SQL https://docs.databricks.com/en/sql/language-manual/functions/dateadd.html
--1. Qual estado tem mais vendedores?

SELECT descUF,
       count(DISTINCT idVendedor) AS qtddeVendedor -- caso eu nao queira que seja uma coluna posso usar o count direto no order by

FROM silver.olist.vendedor
GROUP BY descUF
ORDER BY qtddeVendedor DESC

LIMIT 1


-- COMMAND ----------

-- vamos colocar o count no order by e ter apenas o nome do estado


SELECT descUF      

FROM silver.olist.vendedor
GROUP BY descUF
ORDER BY count(DISTINCT idVendedor) DESC

LIMIT 1

-- COMMAND ----------

-- com having

SELECT descUF,
      count(DISTINCT idVendedor) AS qtddeVendedor      

FROM silver.olist.vendedor
GROUP BY descUF
HAVING qtddeVendedor > 20
ORDER BY count(DISTINCT idVendedor) DESC

LIMIT 1

-- COMMAND ----------

SELECT descUF, qtddeVendedor
FROM (
    SELECT descUF, COUNT(DISTINCT idVendedor) AS qtddeVendedor
    FROM silver.olist.vendedor
    GROUP BY descUF
    HAVING COUNT(DISTINCT idVendedor) > 20
) subquery
ORDER BY qtddeVendedor DESC
LIMIT 10;





-- COMMAND ----------

-- select now

select now() -- aqui mostra a hora de execução do codigo

-- COMMAND ----------

-- podemos usar janela de tempo

select *

from silver.olist.pedido

where dtPedido <= NOW()
     and dtPedido >= NOW() - INTERVAL 3 months

-- COMMAND ----------

SELECT *
FROM silver.olist.pedido
WHERE dtPedido <= current_date()
  AND dtPedido >= date_sub(current_date(), 3); -- AQUI O INTERVALO É EM DIAS 



-- COMMAND ----------

-- AQUI O INTERVALO É EM MESES

SELECT *
FROM silver.olist.pedido
WHERE dtPedido <= current_date()  -- Data atual
  AND dtPedido >= add_months(current_date(), -3);  -- Subtrai 3 meses


-- COMMAND ----------

--2. Qual cidade tem mais clientes?

