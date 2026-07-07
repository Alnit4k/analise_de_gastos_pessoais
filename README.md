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
Dashboard em Power BI construído a partir dos dados tratados, com 4 páginas de análise, permitindo a visualização interativa dos totais e padrões de consumo identificados nas etapas de SQL e Python.

## Sobre o Dashboard

O dashboard é dividido em 4 páginas complementares:

### 1️⃣ Visão Geral
Página inicial com filtros de data e os indicadores-chave do período:
- **Gasto total**: $71,67K
- **Ticket médio**: $15,59
- **Total de transações**: 5K
- **Top categoria**: Coffe (categoria mais frequente)

Traz também um gráfico de linha **"Gasto ao decorrer do tempo"**, mostrando a evolução mensal dos gastos entre jul/2022 e mar/2025 — com picos recorrentes de gastos em determinados meses (destaque para 2023-07 e 2024-07) — e um ranking **"Top 10 Transações"** por categoria, liderado por Coffe, Market, Restuarant e Transport.

### 2️⃣ Comportamento de Consumo
Página de análise por categoria, respondendo "para onde vai o dinheiro":
- **Participação de gastos por categoria** (funil): Restaurant concentra a maior fatia do orçamento, seguido por Travel (29,78%) e Tech (23,8%).
- **Categorias mais frequentes** (volume de transações): Coffe (1.248) e Market (1.142) lideram em frequência, mas não em valor — indicando gastos pequenos e recorrentes.
- **Ticket médio por categoria**: Motel ($675,00) e Travel ($469,56) têm os maiores tickets médios, mesmo sendo pouco frequentes.
- **Distribuição dos gastos** (dispersão): visualiza a relação entre valor médio e volume por categoria.
- **Cards de destaque**: Categoria mais frequente (Coffe, 4.597 transações), Maior ticket médio (Motel, $675,00) e Categoria de maior gasto (Restaurant, $12.615,54 — 17,60% do total).

**Principais insights já extraídos no próprio dashboard:**
- Restaurant concentra a maior parcela do orçamento.
- Coffee é o hábito de consumo mais recorrente.
- Motel possui o maior gasto médio por transação.
- Poucas categorias representam a maior parte das despesas (efeito 80/20).

### 3️⃣ Análise Temporal
Página dedicada a padrões de tempo:
- **Cards**: Mês de maior gasto (2024-07), Ano de maior gasto (2025), Maior valor gasto no mês ($5.509,49) e Dia mais caro da semana (Wednesday).
- **Sum of Month by Month Name**: tendência de crescimento acumulado dos gastos ao longo dos meses do ano.
- **Sum of amount by Time**: distribuição dos gastos por hora do dia, com pico entre as horas 10–20 (período de maior movimentação financeira).
- **Sum of amount by Day Name**: quarta-feira é disparadamente o dia da semana com maior soma de gastos, seguida por terça e sexta, com os finais de semana entre os mais baixos.

### 4️⃣ Detalhamento
Página de suporte com uma tabela detalhada das transações (`tableEx`) e um gráfico combinado de linha/coluna, permitindo explorar os dados brutos por trás dos indicadores das páginas anteriores.

## Principais achados
- O maior volume de transações vem de gastos pequenos e recorrentes (Coffe, Market), enquanto o maior impacto financeiro vem de categorias menos frequentes, porém de ticket alto (Restaurant, Motel, Travel).
- Há sazonalidade nos gastos, com picos concentrados em julho (2023 e 2024) e tendência de crescimento ao longo do ano.
- Quarta-feira é o dia da semana com maior gasto acumulado.
- Restaurant é a categoria de maior impacto financeiro, respondendo por ~17,6% do total gasto.

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

## Dashboard

#### Visao geral
<img width="1317" height="736" alt="Captura de tela 2026-07-06 220003" src="https://github.com/user-attachments/assets/13e4c44b-f980-43cd-ab56-eef0276e8d56" />

#### Comportamento do consumo
<img width="1328" height="748" alt="Captura de tela 2026-07-06 220015" src="https://github.com/user-attachments/assets/d1b799d7-dda7-4156-92df-43f6a9ee2f99" />

#### Analise ao decorer do tempo
<img width="1317" height="732" alt="Captura de tela 2026-07-06 220026" src="https://github.com/user-attachments/assets/5eaa186b-a3b7-42ca-93d7-331cb37b71c0" />
