-- B''H --




with mock_data as
(
select  1  day_seq, 1.0 amt union all
select  2  day_seq, 1.0 amt union all
select  2  day_seq, 1.0 amt union all
select  3  day_seq, 1.0 amt union all
select  6  day_seq, 1.0 amt union all
select  7  day_seq, 1.0 amt union all
select  9  day_seq, 1.0 amt union all
select  10 day_seq, 1.0 amt 
)
-- ----------------------------------------------------------
select   day_seq,
         amt,                
         -- -------------------------------------------------
         sum(amt) over (             
             order by      day_seq
             range between 2 preceding and current row
         ) moving_sum_3_day,    
         -- -------------------------------------------------
         sum(amt) over (             
             order by      day_seq
             rows between 2 preceding and current row
         ) moving_sum_3_rows     
         -- -------------------------------------------------
from     mock_data
         -- -------------------------------------------------
order by day_seq
         