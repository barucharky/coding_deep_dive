-- B''H --

select   year,
         sum(number) over (partition by year) number_of_names
         -- cumalitive_number_of_names,
         -- total_number_of_names,
         -- year_pct_from_total
         -- ----------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
where    lower(name) in ('mendy', 'mendi', 'mendel', 'menachem')
  and    gender = 'M'