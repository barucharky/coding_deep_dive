# B''H

---

## Solution to task 22

1. get the 3-day sum by county
2. give a rank the 3-day sums by county
3. group by the rank and pivot the data

---

```sql
with day_level_data as
(
select   lower(county) county, 
         extract(dayofyear from date) day_of_year,
         -- ---------------------------------------------- 
         sum(bottles_sold) bottles_sold         
         -- ---------------------------------------------- 
from     `bigquery-public-data.iowa_liquor_sales.sales` 
         -- ----------------------------------------------
where    lower(county) in ('polk', 'scott', 'clinton')
  and    extract(year from date) = 2017
         -- ---------------------------------------------- 
group by lower(county), 
         extract(dayofyear from date)    
),


-- Here the 3-day sums are created
rolling_sums as
(
select   county,
         day_of_year,
         sum(bottles_sold) over(
             partition by county
             order by     day_of_year
             range between 3 preceding and current row
         ) three_day_sum
         -- ---------------------------------------------- 
from     day_level_data
),


-- 3-day sums are given a rank
ranked_sums as
(
select   county,
         row_number() over(
                    partition by county
                    order by     three_day_sum desc
                    ) sum_rank,
         -- ---------------------------------------------- 
         three_day_sum
         -- ---------------------------------------------- 
from     rolling_sums
)


-- grouped and ordered by that rank, they are then unpivoted. Sum is used because of group by
select   sum_rank,
         -- ---------------------------------------------- 
         sum(case county when 'clinton' then three_day_sum else 0 end) clinton,
         sum(case county when 'polk'    then three_day_sum else 0 end) polk,
         sum(case county when 'scott'   then three_day_sum else 0 end) scott
         -- ---------------------------------------------- 
from     ranked_sums
group by sum_rank
order by sum_rank
limit 3
```