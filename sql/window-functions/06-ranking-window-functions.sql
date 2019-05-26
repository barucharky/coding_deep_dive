-- B''H --


select   account, 
         search_keyword,
         clicks,         
         -- -------------------------------------------------
         rank() over(
             partition by account
             order by     clicks desc
         ) account_clicks_rank,
         -- -------------------------------------------------
         -- 99% of time use dense_rank
         dense_rank() over(
             partition by account
             order by     clicks desc
         ) account_clicks_dense_rank        
         -- -------------------------------------------------
from     `data-science-course-226116.sql_lessons.google_ads_etl_step_1` 
         -- -------------------------------------------------
where    cost > 45
order by account, account_clicks_dense_rank 

