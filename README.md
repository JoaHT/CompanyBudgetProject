# PROJECT - Company Finances

In this project we are working for a fabricated client who is asking us to answer the question; "Which projects and departments are at risk of being over budget or underperforming? Note that department budgets are set at 2-year intervals. We want to know if a year can cover all expenses" and do 3 separate tasks. 

1. Identify Departments and Projects in Red: Understand which departments or projects are over budget or underperforming, so we can take corrective action.

2. Data Organization: Ensure that data from various sources (e.g., employee information, salary data, department budget and project details) is structured correctly and accessible for reporting.

3. Power BI Dashboard Development: Collaborate with the client to create a comprehensive dashboard that provides visibility into employee performance, salary distribution, and departmental project management. 

STEP 1 = We connect to our SQL Server in SSMS and create a database where we import all of our CSV files. 

STEP 2 = We go through our files and check which columns can be joined together, then create a CTE of the upcoming projects and completed projects, as project_status.

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


STEP 3 = We join all our relevant tables together, along with project_status, and only select the ones we know we need during Power BI visualization. 

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


STEP 4 = We start up Power BI and connect to our SQL Server Database, and use our Queries for the SQL Statement, in order to get the exact data we want. 

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

STEP 5 = We are going to be needing the head shots of each employee and therefore we import our CSV file directly into Power BI. It automatically creates a relationship on the employee.id, so all we need to do is go and check if it works as intended. 

STEP 6 = We create a slicer as well as some Card visuals to portray each employees information on the left, before we create the bulk of our visualizations.

STEP 7 = We go over to our Queries in Power BI and create a reference from our original Query, so that we can use a Group By function in Power BI to group budget, salary cost and project cost into one table. 

STEP 8 = We also want to create a column called Revenue in this new table, so we create a custom column with the calculation; 

	[Budget]*.5 - ([Salary Cost]*2 + [Project Cost])

STEP 9 = Now that we have this new table, we rename it Cost and save it. In Power BI it automatically created a relationship, although in our visualization we dont want it to filter, so we delete that relationship for visualization purposes. 

STEP 10 = Then we create the majority of the dashboard containing two Pie visuals portraying project distribution based on department and status. 

STEP 11 = Next step is making a table of Department goals, Department name, Sum of Project cost, Sum of Salary cost, Revenue, and a new column called 2-year budget which was created through the steps;

	[Budget]*.5

STEP 12 = Next we create the bar charts for Project Budget for each Project, and the Project Budget by department. 

STEP 13 = Finally we create two new sliders and make sure they are only filtering the information we need by pressing the formatting button and then editing the interactions. 


# INSIGHTS - 

Which projects and departments are at risk of being over budget or underperforming? As we can see from the table visual, we can see that Human Resources and their department goal of "Enhance employee engagement" is $25,000 over budget, and is losing the company money. As well we can see that comparatively to the other departments IT and their department goal of "Improve IT infrastructure" is just $58,000 under budget max, meaning that they most likely are underperforming. These two departments are also the departments with the lowest project budget out of the 5 departments, with $105k and $90k respectively, compared to Sales who has a project budget of $150k. Since the budget for Engineering is $770k on the plus side, I would advice the company to redeploy some of the Engineering budget towards the Human Resources budget as to avoid it going into the negatives. In addition to this I would conduct a proper investigation towards the Human Resources project to see if there's any changes that can be made. 
