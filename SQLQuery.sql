-- Queries Basicas 

USE personal_finance

SELECT * 
FROM dbo.[11 march 2025]

SELECT * 
FROM dbo.[11 march 2025]
WHERE amount IS NULL

SELECT DISTINCT
category FROM dbo.[11 march 2025]

SELECT ROUND(SUM(amount), 2) FROM dbo.[11 march 2025]

SELECT category, ROUND(SUM(amount), 2) AS total 
FROM dbo.[11 march 2025] 
GROUP BY category 
ORDER BY total

SELECT category, COUNT(*) AS transactions
FROM dbo.[11 march 2025] GROUP BY category
ORDER BY transactions DESC
 
SELECT category, AVG(amount) AS avg_total
FROM dbo.[11 march 2025] GROUP BY category
ORDER BY avg_total DESC

-- Queries temporais 

SELECT date, CAST(LEFT(date, 19) AS DATETIME) 
AS data_converted, CAST(LEFT(date, 19) AS DATE) 
AS only_data FROM [11 march 2025]

-- Agrupar e contar por mês

SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS

SELECT 
YEAR(CAST(LEFT(date, 19) AS DATETIME)) AS year ,
MONTH(CAST(LEFT(date, 19) AS DATETIME)) AS month ,
COUNT(*) AS records_total,
SUM(amount) AS total_amount
FROM [11 march 2025]
GROUP BY 
YEAR(CAST(LEFT(date, 19) AS DATETIME)),
MONTH(CAST(LEFT(date, 19) AS DATETIME))
ORDER BY year, total_amount

SELECT 
DATEPART(WEEK,CAST(LEFT(date, 19) AS DATETIME)) AS week_number,
COUNT(*) AS total_records,
SUM(amount) AS total_amount
FROM [11 march 2025]
GROUP BY DATEPART(WEEK, CAST(LEFT(date, 19) AS DATETIME))
ORDER BY total_amount

SELECT 
CASE
WHEN DATEPART(HOUR, CAST(LEFT(date, 19) AS DATETIME))  BETWEEN 6 AND 11 THEN 'Morning'
WHEN DATEPART(HOUR, CAST(LEFT(date, 19) AS DATETIME))  BETWEEN 12 AND 17 THEN 'evening'
WHEN DATEPART(HOUR, CAST(LEFT(date, 19) AS DATETIME))  BETWEEN 6 AND 11 THEN 'Night'
ELSE 'dawn'
END AS periodo,
COUNT(*) AS tota_records,
SUM(amount) AS total_amount
FROM [11 march 2025]
GROUP BY 
CASE
WHEN DATEPART(HOUR, CAST(LEFT(date, 19) AS DATETIME))  BETWEEN 6 AND 11 THEN 'Morning'
WHEN DATEPART(HOUR, CAST(LEFT(date, 19) AS DATETIME))  BETWEEN 12 AND 17 THEN 'evening'
WHEN DATEPART(HOUR, CAST(LEFT(date, 19) AS DATETIME))  BETWEEN 6 AND 11 THEN 'Night'
ELSE 'dawn'
END
ORDER BY periodo

-- Queries mais inteligentes

WITH monthly_category AS (
    SELECT
        -- Converte a data limpa para o formato 'YYYY-MM-01' mantendo o tipo DATE
        CAST(FORMAT(CAST(LEFT(date, 19) AS DATETIME), 'yyyy-MM-01') AS DATE) AS month,
        category,
        SUM(amount) AS total
    FROM [11 march 2025]
    GROUP BY CAST(FORMAT(CAST(LEFT(date, 19) AS DATETIME), 'yyyy-MM-01') AS DATE), category
)

SELECT *
FROM (
    SELECT *,
           RANK() OVER(
               PARTITION BY month
               ORDER BY total DESC
           ) AS rk
    FROM monthly_category
) t
WHERE rk = 1;


-- Preparacao para Power BI

SELECT * FROM [11 march 2025]
