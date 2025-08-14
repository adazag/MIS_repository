CREATE view [data_mis_project].[clen_empee_rate]

as

WITH CLEN_EMPEE_RATE_FCT AS (SELECT client_id AS CLEN_ID, employee_id AS EMPEE_ID, id AS CLEN_EMPEE_RATE_ID, rate AS CLEN_EMPEE_RATE_AMT, rate_start_date AS CLEN_EMPEE_RATE_START_DATE, rate_end_date AS CLEN_EMPEE_RATE_END_DATE, 
                                                                       modified_by AS CHNG_EMPEE_ID, modified_at AS CHNG_DATE, currency_code AS CLEN_EMPEE_RATE_CRNCY_CODE, client_rate_id AS RATE_ID, client_rate_card_id AS CLEN_RATE_CARD_ID
                                                         FROM    data_in.client_employee_rate), CLIENT_RATE_CARD AS
    (SELECT id AS RATE_ID, client_id AS CLEN_ID, role_name AS ROLE_NAME, rate AS RATE, currency_code AS CRNCY_CODE, rate_start_date AS RATE_START_DATE, rate_end_date AS RATE_END_DATE, external_role_id AS EXTERNAL_ROLE_ID, 
                 client_rate_card_id AS CLEN_RATE_CARD_ID, seniority AS SENIORITY, internal_role_id AS INTERNAL_ROLE_ID, competency AS COMPETENCY, family AS FAMILY
    FROM    data_in.client_rate_card_vw), RATE_CARD_NAME AS
    (SELECT id AS RATE_CARD_ID, client_id AS CLEN_ID, name AS RATE_CARD_NAME, is_active_ind AS IS_ACTIVE_IND, effective_date AS EFFECTIVE_DATE
    FROM    data_in.client_rate_card), EMPLOYEE_VW AS
    (SELECT 1 AS id_key, id, ldap_login, employee_full_name, line_manager_id, line_manager, phone_number, email, position, location, pg_user_name_deprecated as pg_user_name, pg_t_number_deprecated as pg_t_number, gender_code, nationality, role, active_ind, functional_manager_id, functional_manager, employment_date, 
                 contract_termination_date, contract_type, approval_required, legal_entity, fte, org_unit_id, org_unit_name, team_id, team_name, delivery_team_id, delivery_team_name, senior_delivery_team_id, senior_delivery_team_name, sub_bu_id, sub_bu_name, bu_id, bu_name, 
                 create_ip_ind, gender, photo_ind, allow_photo_usage_ind, primary_competency_name, country, city, country_work_location, city_id, country_id, ad_object_id, az_ad_object_id, az_ad_account_enabled_ind, leave_ind, country_work_location_id, team_leader_ind, team_owner_ind, 
                 management_community_member_ind
    FROM    data_in.org_emp_vw)
    SELECT a.CLEN_ID, a.EMPEE_ID, c.employee_full_name AS EMPEE_NAME, a.CLEN_EMPEE_RATE_ID, a.CLEN_EMPEE_RATE_AMT, a.CLEN_EMPEE_RATE_START_DATE, a.CLEN_EMPEE_RATE_END_DATE, a.CHNG_EMPEE_ID, a.CHNG_DATE, a.CLEN_EMPEE_RATE_CRNCY_CODE, 
                a.RATE_ID, crc.ROLE_NAME, a.CLEN_RATE_CARD_ID, b.RATE_CARD_NAME, b.IS_ACTIVE_IND AS IS_RATE_CARD_ACTIVE_IND, CASE WHEN (COALESCE ([CLEN_EMPEE_RATE_START_DATE], CAST('1999-01-01' AS DATE)) <= GETDATE() AND 
                COALESCE ([CLEN_EMPEE_RATE_END_DATE], CAST('2999-01-01' AS DATE)) >= GETDATE()) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS current_rate_ind, crc.EXTERNAL_ROLE_ID, crc.SENIORITY, crc.INTERNAL_ROLE_ID, crc.COMPETENCY, crc.FAMILY
   FROM    CLEN_EMPEE_RATE_FCT AS a LEFT OUTER JOIN
                RATE_CARD_NAME AS b ON a.CLEN_RATE_CARD_ID = b.RATE_CARD_ID LEFT OUTER JOIN
                EMPLOYEE_VW AS c ON a.EMPEE_ID = c.id LEFT OUTER JOIN
                CLIENT_RATE_CARD AS crc ON crc.RATE_ID = a.RATE_ID
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[clen_empee_rate] TO [data_mis_project_clen_empee_rate_read_all]
    AS [dbo];
GO

