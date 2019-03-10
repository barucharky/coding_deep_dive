/*
B''H

Task 6:

- See the table `data-science-course-226116.sql_lessons.google_ads_etl_step_1` 
- Take a look at the following columns:
    - account       
    - clicks
    - cost
    - avg_cpc
- Note, how avg_cpc is cost divided by clicks rounded to 2 decimal points.
- Make the following query:
    - Show the following columns:
        - account       
        - clicks
        - cost
        - avg_cpc
        - cost_per_click (create this column yourself in the SQL)
    - Only show where clicks is more than 4
    - Only show where your cost_per_click doesn't equal the table's avg_cpc value
    - Sort by cost_per_click descending

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