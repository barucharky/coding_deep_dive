




-- Employee Mock Data: employees
select 1 id, 'Baruch'    first_name, 'Arky'              last_name, 2    dept_id union all
select 2 id, 'Yossi'     first_name, 'David'             last_name, 2    dept_id union all
select 3 id, 'Mendy'     first_name, 'What-if-Effune'    last_name, 3    dept_id union all
select 4 id, 'Lior'      first_name, 'I-dont-kknow-lior' last_name, null dept_id union all
select 5 id, 'Charlie'   first_name, 'Buttons'           last_name, 2    dept_id union all
select 6 id, 'Clarabell' first_name, 'hhhhh'             last_name, 3    dept_id union all
select 7 id, 'Glom'      first_name, 'Pat'               last_name, 6    dept_id 


-- Departments Mock Data: departments
select 1 id, 'Engineering'  name, 3    branch_id union all
select 2 id, 'HR'           name, 3    branch_id union all
select 3 id, 'Tech Support' name, null branch_id union all
select 4 id, 'CS'           name, 1    branch_id union all
select 5 id, 'COO'          name, 9    branch_id  

-- Departments Branch Data: branches
select 1 id, 'B7'       name union all
select 2 id, 'TLV'      name union all
select 3 id, 'JLM'      name union all
select 4 id, 'Damascus' name 
 



-- -----------------------------------------------------------------------

-- employees.dept_id is a Foreign Key (FK) that references departments.id


/*
JOINS
-----

1. INNER JOIN          80%

   Only return the records that have a match


2. LEFT OUTER JOIN     16%
   
   from    a
      left outer join b
   
   Return all records from the left table (a)
   plus any records in the right table (b) that have a match

   
3. CROSS JOIN          3.9%


4. FULL JOIN           .1 %


5. RIGHT OUTER JOIN    NEVER


*/



-- INNER JOIN example 1:

select   emp.*,
         dept.name
from     `data-science-course-226116.sql_lessons.employees` emp
         -- ---------------------------------------
   inner join `data-science-course-226116.sql_lessons.departments` dept
      on dept.id = emp.dept_id
         -- ---------------------------------------

-- same thing but table 
select   emp.*,
         dept.name
from     `data-science-course-226116.sql_lessons.departments` dept
         -- ---------------------------------------
   inner join `data-science-course-226116.sql_lessons.employees` emp
      on dept.id = emp.dept_id
         -- ---------------------------------------

-- ---------------------------------------------------------------------------------------

-- LEFT OUTER JOIN         


-- Level-of-Grain: emp.id
-- Because an employee can max belong to one department
select   emp.*,  
         dept.name
from     `data-science-course-226116.sql_lessons.employees` emp
         -- ---------------------------------------
    left outer join `data-science-course-226116.sql_lessons.departments` dept
      on dept.id = emp.dept_id
         -- ---------------------------------------
order by emp.id         




-- Level-of-Grain: dept.id/emp.id
-- Because there can be multiple employees in a department
select   dept.*,
         emp.first_name,
         emp.last_name
from     `data-science-course-226116.sql_lessons.departments` dept
         -- ---------------------------------------
    left outer join `data-science-course-226116.sql_lessons.employees` emp
      on dept.id = emp.dept_id
         -- ---------------------------------------
order by dept.id         




select   dept.id,
         dept.name,
         count(*)      count_of_all_records, -- wrong, do not use
         count(emp.id) count_of_employees
from     `data-science-course-226116.sql_lessons.departments` dept
         -- ---------------------------------------
    left outer join `data-science-course-226116.sql_lessons.employees` emp
      on dept.id = emp.dept_id
         -- ---------------------------------------       
group by dept.id,
         dept.name





-- Level-of-Grain: dept.id/emp.id
-- Because there can be multiple employees in a department
select   dept.id         dept_id,
         dept.name       dept_name,
         -- ---------------------------------------
         emp.first_name  emp_first_name,
         emp.last_name   emp_last_name,
         -- ---------------------------------------
         br.name         branch_name
         -- ---------------------------------------
from     `data-science-course-226116.sql_lessons.departments` dept
         -- ---------------------------------------
    left outer join `data-science-course-226116.sql_lessons.employees` emp
      on dept.id = emp.dept_id
         -- ---------------------------------------
    left outer join `data-science-course-226116.sql_lessons.branches` br
      on dept.branch_id = br.id
         -- ---------------------------------------         
order by dept.id               




-- Level-of-Grain: dept.id/emp.id
-- Because there can be multiple employees in a department
select   dept.id         dept_id,
         dept.name       dept_name,
         -- ---------------------------------------
         emp.first_name  emp_first_name,
         emp.last_name   emp_last_name,
         -- ---------------------------------------
         br.name         branch_name
         -- ---------------------------------------
         
from     `data-science-course-226116.sql_lessons.departments` dept
         -- ---------------------------------------
    left outer join `data-science-course-226116.sql_lessons.employees` emp
      on dept.id = emp.dept_id
         -- ---------------------------------------
    left outer join `data-science-course-226116.sql_lessons.branches` br
      on dept.branch_id = br.id
         -- ---------------------------------------         
order by dept.id                  





-- CROSS JOIN
select   * 
from     `data-science-course-226116.sql_lessons.company_party` p
         -- ---------------------------------------------
   cross join `data-science-course-226116.sql_lessons.employees` emp
order by emp.id, p.food


select   * 
from     `data-science-course-226116.sql_lessons.company_party` p,
         `data-science-course-226116.sql_lessons.employees` emp
order by emp.id, p.food