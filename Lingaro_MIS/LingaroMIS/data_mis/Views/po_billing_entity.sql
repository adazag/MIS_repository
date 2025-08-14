create view [data_mis].[po_billing_entity] as

with po as (
select p.id PO_ID
,f.project_id PROJ_ID
,legal_entity_id LE_ID,
max(isnull(cast(valid_through_date as date), cast('2999-01-01' as date))) VALID_THRGH_DATE
from [data_in].[fin_purchase_order] p
left join [data_in].[fin_purchase_order_project_mapping] f on p.id=f.PO_ID
group by p.id, f.project_id, legal_entity_id
),

po_nn as (
select
 PROJ_ID
,PO_ID
--,min(po.LE_ID) 
,LE_ID 
,VALID_THRGH_DATE 
,'With PO' as Type
from po
where PO_ID is not null
),

po_wn as (
select 
po.PROJ_ID 
,min(po.PO_ID) as PO_ID
,min(po.LE_ID) LE_ID
,max(VALID_THRGH_DATE) VALID_THRGH_DATE
,'Without PO' as Type
from po
left join data_in.fin_purchase_order_project_mapping f on po.PO_ID=f.PO_ID
where po.PO_ID is not null and po.PROJ_ID is not null
group by po.PROJ_ID
),


tot as (
select PROJ_ID, PO_ID, LE_ID, VALID_THRGH_DATE, Type from po_nn
UNION
select PROJ_ID, PO_ID, LE_ID, VALID_THRGH_DATE,Type from po_wn
),

final as (
select PROJ_ID,PO_ID, a.LE_ID,b.name as LE_NAME, VALID_THRGH_DATE,Type from tot a
left join data_in.org_legal_entity b on a.LE_ID=b.id
)


select PROJ_ID, PO_ID, LE_ID, LE_NAME, VALID_THRGH_DATE,Type 
from final 
where PROJ_ID is not null
GO

