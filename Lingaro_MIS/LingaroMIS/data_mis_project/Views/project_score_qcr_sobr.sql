create view [data_mis_project].[project_score_qcr_sobr] as
with partial_score_usual as (
select 
    c.customer_name,
    b.assessor_id,
    concat(convert(nvarchar(50),trim(b.first_name)),' ',convert(nvarchar(50),trim(b.last_name))) as assessor,
    concat(convert(nvarchar(50),trim(i.last_name)),' ',convert(nvarchar(50),trim(i.first_name))) as service_partner,
    i.service_partner_id,
    i.partner_email,
    j.EMPEE_ID as service_partner_id_sulu,
    a.rdate as assessment_date,
    d.category_name,
    a.score,
    k.project_id,
    isnull(b.location,'') as assessor_location
    --replace(replace(replace(comment,';',''),'"',''),'-','') as comment
from 
    data_in_cxms.fact_score_partial a
left join
    data_in_cxms.dim_assessor b on a.assessor_id=b.assessor_id
left join
    data_in_cxms.dim_customer c on b.customer_id=c.customer_id
left join
    data_in_cxms.dim_assessment_category d on a.category_id=d.category_id
left join
    data_in_cxms.dim_assessor_service_partner h on a.assessor_id=h.assessor_id and a.rdate=h.rdate
left join   
    data_in_cxms.dim_service_partner i on h.partner_id=i.service_partner_id
left join
    data_in_cxms.emp_hierarchy j on i.partner_email=j.EMPEE_EMAIL
left join
    data_in_cxms.dim_assessor_project k on a.rdate=k.rdate and b.assessor_id=k.assessor_id
where
    i.active=1 and isnull(b.reason,0)<>'duplicated' and
    ((c.customer_name in ('P&G','Procter & Gamble')
    or (c.customer_name not in ('P&G','Procter & Gamble') and a.rdate>='2019-06-30')))
    --and i.partner_email not like '%.vom%'
),
partial_score_old_qcr as (
select 
    c.customer_name,
    b.assessor_id,
    concat(convert(nvarchar(50),trim(b.first_name)),' ',convert(nvarchar(50),trim(b.last_name))) as assessor,
    concat(convert(nvarchar(50),trim(i.last_name)),' ',convert(nvarchar(50),trim(i.first_name))) as service_partner,
    i.service_partner_id,
    i.partner_email,
    k.EMPEE_ID as service_partner_id_sulu,
    a.rdate as assessment_date,
    d.category_name,
    a.score,
    j.project_id,
    isnull(b.location,'') as assessor_location
    --replace(replace(replace(comment,';',''),'"',''),'-','') as comment
from 
    data_in_cxms.fact_score_partial a
left join
    data_in_cxms.dim_assessor b on a.assessor_id=b.assessor_id
left join
    data_in_cxms.dim_customer c on b.customer_id=c.customer_id
left join
    data_in_cxms.dim_assessment_category d on a.category_id=d.category_id
left join
    data_in_cxms.dim_assessor_service_partner h on a.assessor_id=h.assessor_id and a.rdate=h.rdate
left join   
    data_in_cxms.dim_service_partner i on h.partner_id=i.service_partner_id
left join
    data_in_cxms.dim_assessor_project j on a.rdate=j.rdate and b.assessor_id=j.assessor_id
left join
    data_in_cxms.emp_hierarchy k on i.partner_email=k.EMPEE_EMAIL
where
    i.active=1 and isnull(b.reason,0)<>'duplicated' and c.customer_name not in ('P&G','Procter & Gamble') and a.rdate<'2019-06-30'
),
merged as (
select * from partial_score_usual
union all
select * from partial_score_old_qcr
),
avg_results as (
select project_id, customer_name, service_partner, assessment_date, avg(score) score, count(distinct(assessor_id)) number_of_assessors 
from merged
where category_name = 'Overall'
  and assessment_date >= '2019-02-01'
  and convert(varchar(20), project_id) not like '%1000'
group by project_id, customer_name, service_partner, assessment_date
),
proj_latest_date as (
select project_id, max(assessment_date) max_date 
from avg_results
group by project_id
)

select ar.Project_id
  , case when ar.customer_name like 'Procter & Gamble' then 'SOBR' else 'QCR' end "QCR/SOBR"
  , ar.service_partner "Service Partner"
  , ar.assessment_date "Date"
  , ar.Score
  , case when pld.max_date = ar.assessment_date then 1 else 0 end "Latest score"
  , ar.number_of_assessors
from avg_results ar
join proj_latest_date pld on pld.project_id = ar.project_id
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[project_score_qcr_sobr] TO [data_mis_project_project_score_qcr_sobr_read_all]
    AS [dbo];
GO

