



CREATE   VIEW [data_mis].[org_unit_map_new] AS 

with


------------------------------
/*Organizational unit list*/
------------------------------

Org_unit as (
select *
from data_in.org_unit
where start_date>='2024-01-01' or end_date is null or end_date >= '2024-01-01'
),

------------------------------
/*LEVEL_1_BU*/
------------------------------

LEVEL_1_BU as (
select *
from org_unit
where team_level=1
),
------------------------------
/*LEVEL_2_SBU*/
------------------------------

LEVEL_2_SBU as (
select *
from org_unit
where team_level=2
),

------------------------------
/*LEVEL_3_DT*/
------------------------------

LEVEL_3_SDT as (
select *
from org_unit
where (team_level=4 or team_level=3) and type='SDT'
),

------------------------------
/*LEVEL_4_T*/
------------------------------

LEVEL_4_DT as (
select *
from org_unit
where (team_level=4 or team_level=3) and type='DT'
),
------------------------------
/*LEVEL_5_T*/
------------------------------

LEVEL_5_T as (
select *
from org_unit
where (team_level=5 or team_level=4) and type='CT'
),


------------------------------
/*Org_Unit+L5*/
------------------------------
OU_L5 as (
select  
 a.id as ORG_ID
,a.name as ORG_NAME
,a.team_level as LEVEL
,a.leader_id
,b.id as T_ID
,b.name as T_NAME
,case when b.id is null then a.id else b.parent_id end as id_next_level
from Org_unit a
full join LEVEL_5_T b on a.id=b.id
),
------------------------------
/*Org_Unit+L5+L4*/
------------------------------
OU_L5_L4 as (
select  
 a.ORG_ID
,a.ORG_NAME
,a.LEVEL
,a.leader_id
,a.T_ID
,a.T_NAME
,b.id as DT_ID
,b.name as DT_NAME
,case when b.id is null then a.id_next_level else b.parent_id end as id_next_level
from OU_L5 a
full join LEVEL_4_DT b on a.id_next_level=b.id
),


------------------------------
/*Org_Unit+L5+L4+L3*/
------------------------------
OU_L5_L4_L3 as(
select 
 b.ORG_ID
,b.ORG_NAME
,b.LEVEL
,b.leader_id
,b.T_ID
,b.T_NAME
,b.DT_ID
,b.DT_NAME
,c.id as SDT_ID
,c.name as SDT_NAME
,case when c.id is null then b.id_next_level else c.parent_id end as id_next_level
from OU_L5_L4 b
full join LEVEL_3_SDT c on b.id_next_level=c.id
),

------------------------------
/*Org_Unit+L5+L4+L3_L2*/
------------------------------
OU_L5_L4_L3_L2 as(
select 
 c.ORG_ID
,c.ORG_NAME
,C.LEVEL
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
from OU_L5_L4_L3 c
full join LEVEL_2_SBU d on c.id_next_level=d.id
),

------------------------------
/*Org_Unit+L5+L4+L3+L2+L1*/
------------------------------
OU_L5_L4_L3_L2_L1 as(
select 
 c.ORG_ID
,c.ORG_NAME
,C.LEVEL
,c.leader_id
,c.T_ID
,c.T_NAME
,c.DT_ID
,c.DT_NAME
,c.SDT_ID
,c.SDT_NAME
,c.SBU_ID
,c.SBU_NAME
,d.id as BU_ID
,d.name as BU_NAME
,case when d.id is null then c.id_next_level else d.parent_id end as id_next_level
from OU_L5_L4_L3_L2 c
full join LEVEL_1_BU d on c.id_next_level=d.id
),

--insert into data_mis_project.fc_org_unit
Total as (select 
ORG_ID
,ORG_NAME
,LEVEL
,leader_id as LEADER_ID
,CONCAT(b.first_name,' ',b.last_name) as LEADER_NAME
,b.email as LEADER_EMAIL
,T_ID as TEAM_ID
,T_NAME as TEAM_NAME
,DT_ID as DELIVERY_TEAM_ID
,DT_NAME as  DELIVERY_TEAM_NAME
,SDT_ID as SENIOR_DELIVERY_TEAM_ID
,SDT_NAME as SENIOR_DELIVERY_TEAM_NAME
,SBU_ID as SUB_BUSINESS_UNIT_ID
,SBU_NAME as SUB_BUSINESS_UNIT_NAME
,BU_ID as BUSINESS_UNIT_ID
,BU_NAME as BUSINESS_UNIT_NAME
from OU_L5_L4_L3_L2_L1 a
LEFT JOIN data_in.org_emp b on a.leader_id=b.id
)


select *
from Total
--where ORG_ID=809

;
GO

