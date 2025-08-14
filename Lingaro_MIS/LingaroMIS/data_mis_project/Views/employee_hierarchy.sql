


CREATE view [data_mis_project].[employee_hierarchy] as

--HIERARCHIA PO NAZWISKACH
WITH EmpWithManagerEmail AS (
    -- Tworzymy tymczasowe pole line_manager_email
    SELECT 
        e.id AS employee_id,
        e.email AS employee_email,
        m.email AS line_manager_email
    FROM data_in.org_emp_vw e
    LEFT JOIN data_in.org_emp_vw m ON e.line_manager_id = m.id
    WHERE e.active_ind = 1 AND e.id > 0 AND e.line_manager_id IS NOT NULL
),

ManagerHierarchy AS (
    -- Start: każdy pracownik z jego managerem
    SELECT 
        e.employee_id,
        e.employee_email,
        e.line_manager_email,
        CAST(e.line_manager_email AS VARCHAR(MAX)) AS manager_chain,
        CAST(e.employee_email + '/' + COALESCE(e.line_manager_email, '') AS VARCHAR(MAX)) AS visited_emails
    FROM EmpWithManagerEmail e
    WHERE e.line_manager_email IS NOT NULL

    UNION ALL

    -- Rekurencja: dołącz managera wyżej po e-mailu
    SELECT 
        mh.employee_id,
        mh.employee_email,
        m.line_manager_email,
        CAST(mh.manager_chain + ' / ' + m.line_manager_email AS VARCHAR(MAX)),
        CAST(mh.visited_emails + '/' + COALESCE(m.line_manager_email, '') AS VARCHAR(MAX))
    FROM ManagerHierarchy mh
    JOIN EmpWithManagerEmail m ON mh.line_manager_email = m.employee_email
    WHERE CHARINDEX('/' + m.line_manager_email + '/', '/' + mh.visited_emails + '/') = 0
)

-- Finalny wynik: tylko pełna ścieżka dla każdego pracownika
SELECT 
    employee_id,
    employee_email,
    MAX(manager_chain) AS manager_chain
FROM ManagerHierarchy
--WHERE employee_id = 223338
GROUP BY employee_id, employee_email
--OPTION (MAXRECURSION 0);



--HIERARCHIA PO IDKACH
--WITH ManagerHierarchy AS (
--    -- Start: każdy pracownik z jego managerem
--    SELECT 
--        id AS employee_id,
--        line_manager_id,
--        CAST(CAST(line_manager_id AS VARCHAR(MAX)) AS VARCHAR(MAX)) AS manager_chain,
--        CAST(CAST(id AS VARCHAR(MAX)) + '/' + CAST(line_manager_id AS VARCHAR(MAX)) AS VARCHAR(MAX)) AS visited_ids
--    FROM data_in.org_emp
--    WHERE active_ind = 1 AND id > 0 AND line_manager_id IS NOT NULL

--    UNION ALL

--    -- Rekurencja: dołącz managera wyżej
--    SELECT 
--        mh.employee_id,
--        e.line_manager_id,
--        CAST(mh.manager_chain + ' / ' + CAST(e.line_manager_id AS VARCHAR(MAX)) AS VARCHAR(MAX)),
--        CAST(mh.visited_ids + '/' + CAST(e.line_manager_id AS VARCHAR(MAX)) AS VARCHAR(MAX))
--    FROM ManagerHierarchy mh
--    JOIN data_in.org_emp e ON mh.line_manager_id = e.id
--    WHERE e.active_ind = 1
--      AND e.id > 0
--      AND CHARINDEX('/' + CAST(e.line_manager_id AS VARCHAR(MAX)) + '/', '/' + mh.visited_ids + '/') = 0 -- unikanie cykli
--)

---- Finalny wynik: tylko pełna ścieżka dla każdego pracownika
--SELECT 
--    employee_id,
--    MAX(manager_chain) AS manager_chain
--FROM ManagerHierarchy
----WHERE employee_id = 223338
--GROUP BY employee_id
----OPTION (MAXRECURSION 0);

--GO
GO

