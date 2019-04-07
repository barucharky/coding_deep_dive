-- B''H --
with 

year_names as 
(
select   year,
         number,
         sum(number) over (partition by year) number_of_names
         -- ----------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
where    lower(name) in ('mendy', 'mendi', 'mendel', 'menachem')
  and    gender = 'M'
),

numbers as
(
select   year,
         number_of_names,
         sum(number_of_names) over(
           rows between unbounded preceding and current row
         ) cumalitive_number_of_names,
         sum(number) over() total_number_of_names
from     year_names
)

select   *,
         round(
           (number_of_names/sum(total_number_of_names) over (partition by year)) * 100,
           2
         ) year_pct_from_total
from     numbers