with cte as (
select 
  b.parent_client_id
, b.ano
, b.mes
, sum(b.valor_venda) as vendas_mes
, sum(vendas_mes) over (partition by b.client_id order by ano, mes rows between 6 preceding and current row) as vendas_acumulado_mes_a_mes
, avg(b.dias_entre_vendas) as intervalo_medio_vendas
, row_number () over (partition by b.parent_client_id order by ano, mes) as rn
from (
	select
	  a.parent_client_id
	, date_part(year, date_trunc('year', b.created_at)) as ano
	, date_part(month, date_trunc('month', b.created_at)) as mes
	, b.gross_value as valor_venda
	, lead(b.created_at) over (partition by a.parent_client_id  order by b.created_at asc) as lead_date
	, datediff(day, b.created_at, lead_date) as dias_entre_vendas
	inner join vendas_clientes b
	on a.client_uuid = b.client_uuid
	where b.created_at >= '2020-01-01'
	) b
group by 1, 2, 3
order by b.parent_client_id, b.ano, b.mes
)
select 
  b.name as dono_da_rede
, b.cpf_cnpj as cpf_cnpj_rede
, a.ano
, a.mes
, a.vendas_mes
, case when rn >= 6 then vendas_acumulado_mes_a_mes else 0 end vendas_acumulado_6_meses
, a.intervalo_medio_vendas
from cte a
inner join cadastro_clientes b
on a.parent_client_id = b.parent_client_id
