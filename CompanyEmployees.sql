-- Project status
-- Project status
WITH project_status AS (
SELECT 
project_id,
project_name,
project_budget,
'upcoming' as status
FROM [upcoming projects]
union ALL
SELECT 
project_id,
project_name,
project_budget,
'completed' as status
FROM completed_projects)


--Big table
SELECT 
e.employee_id, 
e.first_name, 
e.last_name,
e.job_title,
e.salary,
e.hire_date,
d.Department_Name,
d.Department_Budget,
d.Department_Goals,
pa.project_id,
p.project_name,
p.project_budget,
p.status
FROM employees as e
join departments as d ON e.department_id = d.Department_ID
join project_assignments as pa ON e.employee_id = pa.employee_id
join project_status as p ON pa.project_id = p.project_id