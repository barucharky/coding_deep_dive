--B''H--

/*
________________________________________________________________________________
This document shows some benefits of using hash to find and manage duplicates in 
data sets. First two methods that don't use hash are shown for comparison
________________________________________________________________________________
*/


/*
FINDING DUPLICATES METHOD 1:

Pros:
- Works for simple tasks

Cons:
- No easy/clean/fast way to view what rows are duplicates and non-duplicates
- Need to redo for entire dataset everytime a new record comes in
*/


select   id,
         first_name,
         last_name,
         dept_id,
         -- --------------------------------------------
         count(*)
from     `data-science-course-226116.sql_lessons.employees_with_dupes`
         -- --------------------------------------------
group by id,
         first_name,
         last_name,
         dept_id
         -- --------------------------------------------
having   count(*) > 1         




/*
FINDING DUPLICATES METHOD 2:

Pros:
- Works for simple tasks

Cons:
- Need to redo for entire dataset everytime a new record comes in
*/

with stg as
(
select   id,
         first_name,
         last_name,
         dept_id,
         -- --------------------------------------------
         row_number() over (
             partition by id,
                          first_name,
                          last_name,
                          dept_id
         ) partition_seq_no
         -- --------------------------------------------
from     `data-science-course-226116.sql_lessons.employees_with_dupes`
         -- --------------------------------------------
order by id,
         first_name,
         last_name,
         dept_id
         -- --------------------------------------------
)
select   *,
         case when partition_seq_no > 1 then 'dupe' else 'keep' end dupe_or_keep
from     stg
--where    partition_seq_no = 1 -- only keep the non-dupes 
order by id,
         first_name,
         last_name,
         dept_id




/*
FINDING DUPLICATES METHOD 3:

Pros:
- No deed to redo for entire dataset everytime a new record comes in
- Can easily/cleanly/quickly view rows that are duplicates and non-duplicates
- Generates a nice reference ID for later usage

Cons:
- Slightly more complicated
- Be careful with coalesce part
*/


select   id,
         first_name,
         last_name,
         dept_id,
         -- --------------------------------------------
         to_hex(
             sha512(
                 -- ------------------------------------
                 concat(
                     -- --------------------------------
                     coalesce(
                         cast(id as string),
                         'ID-FIELD'
                     ),
                     -- --------------------------------
                     coalesce(
                         first_name,
                         'FIRST_NAME-FIELD'
                     ),
                     -- --------------------------------
                     coalesce(
                         last_name,
                         'LAST_NAME-FIELD'
                     ),
                     -- --------------------------------
                     coalesce(
                         cast(dept_id as string),
                         'DEPT_ID-FIELD'
                     )
                     -- --------------------------------                     
                 )
                 -- ------------------------------------
             )
         ) hash_sha512
         -- --------------------------------------------
from     `data-science-course-226116.sql_lessons.employees_with_dupes`
         -- --------------------------------------------
order by id,
         first_name,
         last_name,
         dept_id
         -- --------------------------------------------




/*
This is how to deal with incoming data using hashes. It puts all the incoming
data on the left and all the duplicates from the old data on the right.
*/


with incoming_data as
(
select 1 id, 'Mendy' first_name, 'cha' last_name, 99 dept_id union all
select 1 id, 'Mendy' first_name, 'cha' last_name, 99 dept_id union all
select 2 id, 'Yossi' first_name, 'David' last_name, 2 dept_id
),
-- -----------------------------------------------------
incoming_data_with_hash as
(
select   id,
         first_name,
         last_name,
         dept_id,
         -- --------------------------------------------
         to_hex(
             sha512(
                 -- ------------------------------------
                 concat(
                     -- --------------------------------
                     coalesce(
                         cast(id as string),
                         'ID-FIELD'
                     ),
                     -- --------------------------------
                     coalesce(
                         first_name,
                         'FIRST_NAME-FIELD'
                     ),
                     -- --------------------------------
                     coalesce(
                         last_name,
                         'LAST_NAME-FIELD'
                     ),
                     -- --------------------------------
                     coalesce(
                         cast(dept_id as string),
                         'DEPT_ID-FIELD'
                     )
                     -- --------------------------------                     
                 )
                 -- ------------------------------------
             )
         ) hash_sha512
         -- --------------------------------------------
from     incoming_data          
         -- --------------------------------------------
)
-- -----------------------------------------------------
select   i.id             incoming_id,
         i.first_name     incoming_first_name,
         i.last_name      incoming_last_name,
         i.dept_id        incoming_dept_id,
         i.hash_sha512    incoming_hash_sha512,
         -- --------------------------------------------
         emp.id           emp_id,
         emp.first_name   emp_first_name,
         emp.last_name    emp_last_name,
         emp.dept_id      emp_dept_id,
         emp.hash_sha512  emp_hash_sha512
         -- --------------------------------------------
from     incoming_data_with_hash i
    left outer join `data-science-course-226116.sql_lessons.employees_with_sha512` emp
      on i.hash_sha512 = emp.hash_sha512
