/*1)	For any employees with a missing department id, 
        list the employee's id, first name, and last name, and 
        their manager's id, first name, last name, and department id.[4 marks]*/

SELECT emp.employee_id, emp.first_name, emp.last_name, emp.manager_id,
mgr.first_name AS "mgr fName", mgr.last_name AS "mgr lName", mgr.department_id AS "mgr dep id"
FROM HR.Employees emp JOIN  HR.Employees mgr ON emp.manager_id = mgr.employee_id
WHERE emp.department_id IS NULL;

/*2)	List the employee id, first name, last name, hire date (in the form of "November 16, 2009")
        and current job title for the employees who have the earliest hire date. [4 marks]*/
        
select emp.employee_id, emp.first_name,emp.last_name,TRIM(TO_CHAR(emp.hire_date,'Month DD,YYYY' )) as "hire date" , job.job_title
FROM HR.employees emp JOIN HR.jobs job ON emp.job_id = job.job_id 
WHERE emp.hire_date = (select MIN( hire_date) from HR.employees) ;


/*3)	List all locations (location id and city) and the departments associated with 
        each location (department id and name), and the number of employees working for that department.
        All locations should be listed even if there are no departments associated with that location. Order the results by location id.
        For locations with many departments, order by department id. [5 marks]*/
        
SELECT loc.location_id, loc.city ,dep.department_id, dep.department_name ,  COUNT(emp.employee_id) 
FROM HR.locations loc LEFT join HR.departments dep on loc.location_id = dep.location_id LEFT join HR.employees emp on emp.department_id = dep.department_id 
GROUP BY dep.department_id, dep.department_name, loc.city, loc.location_id 
ORDER BY loc.location_id, dep.department_id;


/*4)	An employee is hired into an initial position and may change jobs while with the company. 
        The Employees table shows the current position. Old positions are tracked in the Job_History table. 
        Create a query that will list all employees (id, last name, first name) and the job id and title for all their jobs both current and previous. 
        For previous jobs, show the end date, and for current positions display "present". Sort the results by id and then end date.[5 marks]*/
        
select emp.employee_id, emp.last_name, emp.first_name, emp.job_id, job.job_title, 'present' as "enddate" 
FROM HR.employees emp join HR.jobs job ON emp.job_id = job.job_id 

UNION

select emp.employee_id, emp.last_name, emp.first_name, emp.job_id, job.job_title, TO_CHAR( his.end_date )as "enddate" 
FROM HR.employees emp join HR.job_history his ON emp.employee_id = his.employee_id join  HR.jobs job ON his.job_id = job.job_id 

ORDER BY employee_id, 6 
;
       

/*5)	Use a correlated subquery for this question.
        List departments (department id and name) and the average salary for the employees 
        in each department where the average salary for that department is more than the average salary for departments in the same location.[6 marks]
*/

SELECT  dep.department_id, dep.department_name ,AVG(salary) AS average , dep.location_id
FROM HR.employees emp
JOIN HR.departments dep ON emp.department_id = dep.department_id  GROUP BY  dep.department_id ,dep.department_name ,dep.location_id

HAVING AVG(salary) IN ((SELECT  MAX(AVG(salary)) 
FROM HR.employees e
JOIN HR.departments d ON e.department_id = d.department_id WHERE  d.location_id = dep.location_id GROUP BY d.department_id ));

