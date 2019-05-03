--B''H--

-- don't understand the error: Syntax error: Missing whitespace between literal and alias 

select   timestamp,
         size,
         location,
         -- ----------------------------
         avg(size) over(
             order by timestamp
             range between 2 preceding and current row
         ) 3_day_moving_avg,
         -- ----------------------------
         avg(size) over(
             order by timestamp
             rows  between 2 preceding and current row
         ) 3_report_moving_avg,
         -- ----------------------------
         county,
         state
from     `bigquery-public-data.noaa_severe_storms.hail_reports` 
order by 1