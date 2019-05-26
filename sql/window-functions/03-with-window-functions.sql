-- B''H --




select   account, 
         campaign,
         search_keyword,
         clicks,
         cost,
         -- -------------------------------------------------
         sum(cost) over () total_cost,
         sum(cost) over (partition by account) account_cost,
         sum(cost) over (partition by account, search_keyword) account_search_keyword_cost,
         -- -------------------------------------------------
         round(
             (cost/sum(cost) over (partition by account)) * 100,
             2
             ) cost_pct_of_total_account_cost
         -- -------------------------------------------------
from     `data-science-course-226116.sql_lessons.google_ads_etl_step_1` 
         -- -------------------------------------------------
where    cost > 45
order by account, search_keyword 

