# Análise de Gastos Pessoais

Projeto de análise de dados financeiros pessoais, cobrindo todo o fluxo de um pipeline simples de dados: **coleta (CSV) → banco de dados (SQL Server) → análise exploratória (Python) → visualização (Power BI)**.

O objetivo é transformar um extrato bruto de transações em insights sobre hábitos de consumo: para onde o dinheiro está indo, em quais categorias, em quais períodos do dia/semana/mês e quais tendências aparecem ao longo do tempo.

## Estrutura do repositório

```
analise_de_gastos_pessoais/
├── data/
│   ├── 11_march_2025.csv     # Base principal de transações
│   ├── budget_data.csv       # Variação/cópia da base de transações
│   └── budjet.csv            # Variação/cópia da base de transações
├── SQLQuery.sql               # Consultas SQL Server (exploração e agregações)
├── EDA.ipynb                  # Análise exploratória em Python (pandas)
└── dashboard.pbix             # Dashboard interativo em Power BI
```

### 📄 `data/`
Arquivos CSV com o histórico de transações financeiras, no formato `date, category, amount` (data/hora da transação, categoria do gasto — ex.: Mercado, Restaurante, Café — e valor gasto).

### 📄 `SQLQuery.sql`
Script de consultas em T-SQL (SQL Server) organizado em três blocos progressivos:
- **Queries básicas** — exploração inicial da tabela: contagem de nulos, categorias distintas, soma total gasta, total e média de gastos por categoria, ranking de categorias por número de transações.
- **Queries temporais** — tratamento da coluna de data (originalmente `nvarchar`, convertida com `LEFT()` + `CAST()`), agrupamento de gastos por ano/mês, por semana e por período do dia (manhã, tarde, noite, madrugada).
- **Queries mais avançadas** — uso de CTE e `RANK() OVER (PARTITION BY ...)` para identificar a categoria de maior gasto em cada mês, além de uma query final de preparação dos dados para consumo no Power BI.

### 📄 `EDA.ipynb`
Notebook Python com análise exploratória usando **pandas**: carregamento do CSV, conversão da coluna de data para `datetime`, checagem de tipos e valores nulos, e criação de colunas derivadas (ano-mês, mês numérico e nome do mês) para apoiar as agregações temporais.

### 📄 `dashboard.pbix`
Dashboard em Power BI construído a partir dos dados tratados, com páginas de análise temporal e de tendências de gastos, permitindo a visualização interativa dos totais e padrões de consumo identificados nas etapas de SQL e Python.

## Tecnologias utilizadas
- **SQL Server / T-SQL** — armazenamento e consultas analíticas
- **Python (pandas)** — limpeza e análise exploratória dos dados
- **Power BI** — dashboard e visualização final

## Fluxo do projeto
1. Importação do CSV de transações para o SQL Server.
2. Limpeza e conversão de tipos (especialmente a coluna de data).
3. Exploração e agregações via SQL (por categoria, por período de tempo).
4. Análise exploratória complementar em Python com pandas.
5. Construção do dashboard final no Power BI.
