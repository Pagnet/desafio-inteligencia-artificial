WITH Sales_per_month as (
    SELECT 
        client_uuid,
        MONTH(created_at) AS mes,
        SUM(gross_value) AS vendas_mes 
    From Sales as S
    GROUP BY mes, client_uuid
),
acumulado_6_meses as (
    SELECT
        client_uuid,
        SUM(gross_value) AS vendas_6_mes,
        MONTH(created_at) AS mes
    From Sales as S
    GROUP BY mes, client_uuid
    HAVING DATEDIFF(MONTH, created_at, GETDATE())<=6)
)

SELECT 
    C.name as nome_da_rede,
    C.cpf_cnpj as cpf_cnpj_rede,
    YEAR(S.created_at) AS ano,
    AVG(DATEDIFF(DAYS, S.created_at, LAG(S.created_at))) AS intervalo_medio_vendas,
    a6m.vendas_6_mes as vendas_acumulado_6_meses,
    a6m.mes as mes,
    spm.vendas_mes as vendas_mes
From clients as C
LEFT JOIN Sales AS S
    on C.uuid = S.client_uuid
INNER JOIN acumulado_6_meses AS a6m
    on C.uuid = a6m.client_uuid
INNER JOIN Sales_per_month AS spm
    on C.uuid = spm.client_uuid
Where S.created_at >= day('01/01/2020')
