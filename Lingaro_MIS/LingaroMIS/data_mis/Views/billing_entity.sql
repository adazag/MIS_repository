

CREATE view [data_mis].[billing_entity] as 

with po as (
select p.id PO_ID, f.project_id PROJ_ID, p.legal_entity_id LE_ID,
max(isnull(cast(valid_through_date as date), cast('2999-01-01' as date))) VALID_THRGH_DATE
from [data_in].[fin_purchase_order] p
left join [data_in].[fin_purchase_order_project_mapping] f on p.id=f.PO_ID and p.available_amount=f.assigned_amount
group by p.id, f.project_id, legal_entity_id
),

po_nn as (
select PROJ_ID, min(po.LE_ID) LE_ID,  max(VALID_THRGH_DATE) VALID_THRGH_DATE from po
where PROJ_ID is not null
group by PROJ_ID),

po_wn as (
select po.PO_ID, min(po.LE_ID) LE_ID,  max(VALID_THRGH_DATE) VALID_THRGH_DATE, f.project_id PROJ_ID from po
left join [data_in].[fin_purchase_order_project_mapping] f on po.PO_ID=f.PO_ID
where po.PROJ_ID is null
group by po.PO_ID, f.project_id
),

tot as (
select PROJ_ID, LE_ID, VALID_THRGH_DATE from po_nn
UNION
select PROJ_ID, LE_ID, VALID_THRGH_DATE from po_wn
),

final as (
select PROJ_ID, max(VALID_THRGH_DATE) VALID_THRGH_DATE from tot
group by PROJ_ID
)

select a.PROJ_ID, b.LE_ID, le.name as LE_NAME, max(a.VALID_THRGH_DATE) VALID_THRGH_DATE from final a
left join tot b on a.PROJ_ID = b.PROJ_ID and a.VALID_THRGH_DATE=b.VALID_THRGH_DATE
left join data_in.org_legal_entity le on b.LE_ID=le.id
where a.PROJ_ID is not null
group by a.PROJ_ID, b.LE_ID, le.name
GO

