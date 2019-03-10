/*
B"H
Task 6
*/

select            account, 
                  clicks, 
                  cost, 
                  avg_cpc,
                  round(cost / clicks, 2) as cost_per_click
                  -- -----------------------
from              `data-science-course-226116.sql_lessons.google_ads_etl_step_1`
                  -- -----------------------
where             clicks > 4 and 
                  round(cost / clicks, 2) <> avg_cpc
                  -- -----------------------
order by          cost_per_click desc
