-- B''H ---


/*
Important Datatypes:
--------------------

string    : string   : 'Hello World!', '00012'

integer   : int64    : 12
numeric   : numeric  : 123.01, 12.9090

date      : date     : '2019-03-20'
time      : time     : '14:02:03'
datetime  : datetime : '2019-03-20 14:02:03'
*/



-- basic example
select   *  
from     `data-science-course-226116.sql_lessons.states` 



-- cast example
select   states_fips_code, 
         cast(states_fips_code as int64) fips_code 
from     `data-science-course-226116.sql_lessons.states` 


-- -----------------------------------------------------------
-- Datatype: string
select   '0001234' raw_value

-- Datatype: integer
select   cast('0001234' as int64) raw_value

-- Datatype: failed
select   cast('0001234.9' as int64) raw_value


-- Datatype: int
select   safe_cast('0001234.9' as int64) raw_value_1, 
         safe_cast('0001234' as int64)   raw_value_2

-- -----------------------------------------------------------

-- Datatype: numeric
select   cast('0001234.9090' as numeric) raw_value


-- 
select   round(
             cast('0001234.9090' as numeric),
             0
         )
         raw_value_rounded,
         -- --------------------------------------------
         floor(
             cast('0001234.9090' as numeric)             
         )
         raw_value_floored

-- -----------------------------------------------------------         