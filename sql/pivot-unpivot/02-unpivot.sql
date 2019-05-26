-- B''H --



-- ----------------------------------------------------------
-- STEP 1 - Partial query for understanding:
with pivoted as
(
select 1 id, null year_2015, 3.0 year_2016, 3.0 year_2017 union all
select 1 id, 3.0 year_2015, null year_2016, 3.0 year_2017 union all
select 2 id, 3.0 year_2015, 3.0 year_2016, 3.0 year_2017
)
-- ----------------------------------------------------------
select   *
from     pivoted
-- ----------------------------------------------------------




-- ----------------------------------------------------------
-- STEP 2 - Partial query for understanding:
with pivoted as
(
select 1 id, null year_2015, 3.0 year_2016, 3.0 year_2017 union all
select 1 id, 3.0 year_2015, null year_2016, 3.0 year_2017 union all
select 2 id, 3.0 year_2015, 3.0 year_2016, 3.0 year_2017
),
-- ----------------------------------------------------------
years as
(
select   2015 year_value 
union all
select   2016 
union all 
select   2017
)
-- ----------------------------------------------------------
select   *
from     pivoted
   cross join years              
order by id, year_value   
-- ----------------------------------------------------------





-- ----------------------------------------------------------
-- STEP 3 - Complete query
with pivoted as
(
select 1 id, null year_2015, 3.0 year_2016, 3.0 year_2017 union all
select 1 id, 3.0 year_2015, null year_2016, 3.0 year_2017 union all
select 2 id, 3.0 year_2015, 3.0 year_2016, 3.0 year_2017
),
-- ----------------------------------------------------------
years as
(
select   2015 year_value 
union all
select   2016 
union all 
select   2017
)
-- ----------------------------------------------------------
select   id,
         year_value,
         -- ------------------------------------
         case year_value
              when 2015 then year_2015
              when 2016 then year_2016
              when 2017 then year_2017 
         end payment_amount     
         -- ------------------------------------
from     pivoted
   cross join years              
order by id, year_value   
-- ----------------------------------------------------------