-- B''H --


select   account,                           
         day,
         cost,
         -- -------------------------------------------------
         sum(cost) over (
             partition by  account
             order by      day
             range between unbounded preceding and current row
         ) cumalitive_cost_using_range,
         -- -------------------------------------------------
         sum(cost) over (
             partition by account
             order by     day, pk_id
             rows between unbounded preceding and current row
         ) cumalitive_cost_using_rows,         
         -- -------------------------------------------------
         avg(cost) over (
             partition by  account
             order by      account_day_seq_no
             range between 2 preceding and current row
         ) moving_avg_3_day,    
         -- -------------------------------------------------
         avg(cost) over (
             partition by  account
             order by      day, pk_id
             rows between 2 preceding and current row
         ) moving_avg_3_rows     
         -- -------------------------------------------------
from     `data-science-course-226116.sql_lessons.google_ads_etl_step_2` 
         -- -------------------------------------------------
order by account,                          
         day,
         pk_id

