
create view data_out_ad.proj_org_leader as(
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT project_id as [PROJ_ID]
      --,[PROJ_CODE]
      ,name as [PROJ_NAME]
      --,[PROJ_MGR_EMPEE_ID]
      --,[PROJ_ENGAG_TYPE]
      --,[PROJ_ENGAG_NAME]
      --,[PROJ_MGMT_TOOL_NAME]
      --,[PROJ_INVC_INFO_NAME]
      --,[PROJ_START_DATE]
      --,[PROJ_END_DATE]
      --,[CHNG_DATE]
      --,[CHNG_EMPEE_ID]
      --,[CLEN_ID]
      --,[CLEN_NAME]
      --,[PROJ_INVCING_INFO_TXT]
      --,[SVN_LINK_TXT]
      --,[REQD_TMSHT_APPRV_IND]
      --,[TIME_OFF_IND]
      --,[OT_CMPSN_IND]
      --,[CO_HOLDY_IND]
      --,[PARNT_PROJ_IND]
      --,[PARNT_PROJ_ID]
      --,[NEW_CHETH_IND]
      --,[CLEN_PROJ_MGR_NAME]
      --,[SHRPT_LINK_TXT]
      --,[PROJ_STTUS_CODE]
      --,[SHRPT_LINK_PRSNT_IND]
	  ,organization_unit_id as [ORG_UNIT_ID]
      ,organization_unit_name as [ORG_UNIT_NAME]
	  ,b.type as ORG_UNIT_TYPE
	  ,b.leader_id as ORG_UNIT_LEADER_ID
	  ,CONCAT(c.first_name,' ', c.last_name) as ORG_UNIT_LEADER_NAME
	  ,c.email as EMAIL
      --,[PROJ_BLLBL_IND]
      --,[ORGNL_MGMT_IND]
      --,[INVST_IND]
      --,[BU_ID]
      --,[BU_NAME]
      --,[SUB_BU_ID]
      --,[SUB_BU_NAME]
      --,[SENIOR_DELIVERY_TEAM_ID]
      --,[SENIOR_DELIVERY_TEAM_NAME]
      --,[DELIVERY_TEAM_ID]
      --,[DELIVERY_TEAM_NAME]
      --,[TEAM_ID]
      --,[TEAM_NAME]
      --,[REGN_NAME]
      --,[PROJ_STTUS_REQD]
      --,[SERV_AREA_NAME]
      --,[BUS_UNIT_NAME]
      --,[IT_CLEN_PROJ_MGR]
      --,[BUS_CLEN_PROJ_MGR]
      --,[DBL_CNTNG_IND]
      --,[CLOUD_PROJ_IND]
      --,[SOW_SIGN_DATE]
      --,[COUPA_NUM]
      --,[COUPA_CR_NUM]
      --,[PARENT_FIN_PROJ_NAME]
      --,[PARENT_FIN_PROJ_IND]
      --,[PARENT_DC_PROJ_NAME]
      --,[PARENT_DC_PROJ_IND]
      --,[PROJECT_SCALE]
      --,[PROJECT_RISK]
      --,[BUSINESS_CRITICALITY]
      --,[PROJECT_PRIORITY]
      --,[SECURITY_IND]
      --,[INTERNAL_CODE_REPOSITORY]
      --,[AGILE_FRAMEWORK_NAME]
      --,[AGILE_SCORE]
      --,[PROJ_WORK_CATEGORY_NAME]
      --,[USER_COMMENT]
      --,[REASON_TXT]
      --,[MAX_REBASELINE_DATE]
      --,[REBASELINE_MODIFY_DATE]
      --,[REBASLINE_COUNT]
      --,[REBASELINE_COMMENT]
      --,[PROG_ID]
      --,[PROG_NAME]
	  ,az_ad_object_id
  FROM data_mis.proj a
  left join [data_in].[org_unit] b on a.organization_unit_id=b.id
  left join [data_in].[org_emp] c on b.leader_id=c.id
  where organization_unit_id is not null
)
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[proj_org_leader] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[proj_org_leader] TO [data_out_ad_read_all]
    AS [dbo];
GO

