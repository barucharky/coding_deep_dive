-- B''H --

-- CREATE TABLE: `data-science-course-226116.sql_lessons.google_ads_etl_step_2`




select   row_number() over() pk_id, -- primary key
         -- -------------------------------------------------         
         dense_rank() over(
             partition by account
             order by     day
         ) account_day_seq_no,
         *
         -- -------------------------------------------------
from     `data-science-course-226116.sql_lessons.google_ads_etl_step_1` 
         -- -------------------------------------------------
order by pk_id



-- ----------------------------------------------------------

select   *      
         -- -------------------------------------------------
from     `data-science-course-226116.sql_lessons.google_ads_etl_step_2`
         -- -------------------------------------------------
where    pk_id between 1000 and 1010