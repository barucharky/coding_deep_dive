-- B''H --


/*
WRITTEN ORDER
-------------
select   
from  
where 
group by
having
order by

*/


/*
LOGICAL ORDER
-------------
from
where
group by
having
select   
order by

*/


-- ------------------------------------------------------
-- Example 1:
select   state_name  st_name,  
         *
from     `data-science-course-226116.sql_lessons.states` 
where    lower(state_name) like 'a%'
order by st_name 

/*
LOGICAL ORDER:


*/
-- ------------------------------------------------------
