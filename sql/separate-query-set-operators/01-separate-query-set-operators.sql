-- B''H --



/* 
_______________________________________________________________________________________
The UNION set operator combines the result sets of two or more input queries by 
pairing columns from the result set of each query and vertically concatenating them.
_______________________________________________________________________________________
*/

-- -----------------------------------------------------
-- UNION DISTINCT SET OPERATOR
select 'Yossi' first_name, 'David' last_name 
--
union distinct
--
select 'Baruch' first_name, 'Arky' last_name 
--
union distinct
--
select 'Baruch' first_name, 'Arky' last_name 
--
union distinct
--
select 'Baruch' first_name, 'Arky' last_name 
--
union distinct 
--
select 'Baruch' first_name, 'arky' last_name -- note, last name lowercase
-- -----------------------------------------------------



-- -----------------------------------------------------
-- UNION ALL SET OPERATOR
select 'Yossi' first_name, 'David' last_name 
--
union all
--
select 'Baruch' first_name, 'Arky' last_name 
--
union all
--
select 'Baruch' first_name, 'Arky' last_name 
--
union all
--
select 'Baruch' first_name, 'Arky' last_name 
--
union all 
--
select 'Baruch' first_name, 'arky' last_name -- note, last name lowercase
-- -----------------------------------------------------



/* 
_______________________________________________________________________________________
The EXCEPT operator returns rows from the left input query that are not 
present in the right input query.
_______________________________________________________________________________________
*/


-- -----------------------------------------------------
-- EXCEPT DISTINCT SET OPERATOR
-- Note, there is no EXCEPT ALL SET OPERATOR
with people_1 as
(
select 'Yossi' first_name, 'David' last_name 
--
union all
--
select 'Baruch' first_name, 'Arky' last_name 
),
-- -----------------------------------------------------
people_2 as
(
select 'Yossi' first_name, 'David' last_name 
--
union all
--
select 'Mendy' first_name, 'Efune' last_name 
)
-- -----------------------------------------------------
select   first_name, last_name
from     people_1
--
except distinct 
--
select   first_name, last_name
from     people_2
-- -----------------------------------------------------




/* 
_______________________________________________________________________________________
The INTERSECT operator returns rows that are found in the result sets of both 
the left and right input queries. 

Unlike EXCEPT, the positioning of the input queries (to the left vs. right of the INTERSECT operator) 
does not matter.
_______________________________________________________________________________________
*/

-- -----------------------------------------------------
-- INTERSECT DISTINCT SET OPERATOR
-- Note, there is no INTERSECT ALL SET OPERATOR
with people_1 as
(
select 'Yossi' first_name, 'David' last_name 
--
union all
--
select 'Baruch' first_name, 'Arky' last_name 
),
-- -----------------------------------------------------
people_2 as
(
select 'Yossi' first_name, 'David' last_name 
--
union all
--
select 'Mendy' first_name, 'Efune' last_name 
)
-- -----------------------------------------------------
select   first_name, last_name
from     people_1
--
intersect distinct 
--
select   first_name, last_name
from     people_2
-- -----------------------------------------------------