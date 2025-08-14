CREATE   VIEW [data_mis].[org_unit_map] AS 

with

Org_unit as (
select *
from data_in.org_unit
WHERE TYPE in ('OH','BU','SBU','SDT','DT','P','CT','MT','CoE')
--and end_date is null or year(end_date)='2022'
),

------------------------------
/*OH list*/
------------------------------

OH as (
select *
from org_unit
where type='OH'
),
------------------------------
/*BU and CoE and OH list*/
------------------------------

BU_and_CoE as (
select *
from org_unit
where type='BU' or type='CoE'  
),

------------------------------
/*SBU list*/
------------------------------

SBU as (
select *
from org_unit
where type='SBU'
),

------------------------------
/*SDT list*/
------------------------------

SDT as (
select *
from org_unit
where type='SDT'
),

------------------------------
/*DT list*/
------------------------------

DT as (
select *
from org_unit
where type='DT'
),

------------------------------
/*Team list*/
------------------------------

T as (
select *
from org_unit
where type='CT' or type='MT' or type='P'
),

------------------------------
/*OU+T*/
------------------------------
OU_T as (
select  
 a.id as ORG_ID
,a.name as ORG_NAME
,a.type
,a.leader_id
,b.id as T_ID
,b.name as T_NAME
,case when b.id is null then a.id else b.parent_id end as id_next_level
from Org_unit a
full join T b on a.id=b.id
),
------------------------------
/*OU+DT*/
------------------------------
OU_T_DT as (
select  
 a.ORG_ID
,a.ORG_NAME
,a.type
,a.leader_id
,a.T_ID
,a.T_NAME
,b.id as DT_ID
,b.name as DT_NAME
,case when b.id is null then a.id_next_level else b.parent_id end as id_next_level
from OU_T a
full join DT b on a.id_next_level=b.id
),


------------------------------
/*OU+DT+SDT*/
------------------------------
OU_DT_SDT as(
select 
 b.ORG_ID
,b.ORG_NAME
,b.type
,b.leader_id
,b.T_ID
,b.T_NAME
,b.DT_ID
,b.DT_NAME
,c.id as SDT_ID
,c.name as SDT_NAME
,case when c.id is null then b.id_next_level else c.parent_id end as id_next_level
from OU_T_DT b
full join SDT c on b.id_next_level=c.id
),

------------------------------
/*OU+DT+SDT+SBU*/
------------------------------
OU_DT_SDT_SBU as(
select 
 c.ORG_ID
,c.ORG_NAME
,C.type
,c.leader_id
,c.T_ID
,c.T_NAME
,c.DT_ID
,c.DT_NAME
,c.SDT_ID
,c.SDT_NAME
,d.id as SBU_ID
,d.name as SBU_NAME
,case when d.id is null then c.id_next_level else d.parent_id end as id_next_level
from OU_DT_SDT c
full join SBU d on c.id_next_level=d.id
),

------------------------------
/*OU+DT+SDT+SBU+BU*/
------------------------------
OU_DT_SDT_SBU_BU as(
select 
 e.ORG_ID
,e.ORG_NAME
,E.type
,e.leader_id
,e.T_ID
,e.T_NAME
,e.DT_ID
,e.DT_NAME
,e.SDT_ID
,e.SDT_NAME
,e.SBU_ID
,e.SBU_NAME
,f.id as BU_ID
,f.name as BU_NAME
,case when f.id is null then e.id_next_level else f.parent_id end as id_next_level
from OU_DT_SDT_SBU e
full join BU_and_CoE f on e.id_next_level=f.id
),
------------------------------
/*OU+DT+SDT+SBU+BU+OH*/
------------------------------
OU_DT_SDT_SBU_BU_OH as(
select 
 g.ORG_ID
,g.ORG_NAME
,G.type
,g.leader_id
,g.T_ID
,g.T_NAME
,g.DT_ID
,g.DT_NAME
,g.SDT_ID
,g.SDT_NAME
,g.SBU_ID
,g.SBU_NAME
,g.BU_ID
,g.BU_NAME
,h.id as OH_ID
,h.name as OH_NAME
,case when h.id is null then g.id_next_level else h.parent_id end as parnt_id_next_level
from OU_DT_SDT_SBU_BU g
full join OH h on g.id_next_level=h.id
),

--insert into data_mis_project.fc_org_unit
Total as (select 
ORG_ID
,ORG_NAME
,type as TYPE
,leader_id as LEADER_ID
,T_ID
,T_NAME
,DT_ID
,DT_NAME
,SDT_ID
,SDT_NAME
,SBU_ID
,SBU_NAME
,BU_ID
,BU_NAME
,OH_ID
,OH_NAME


from OU_DT_SDT_SBU_BU_OH
)

select *  
from Total
;
GO

