--B''H--

with

year_level as
(
select   year,
         sum(number) number_of_names
         -- ----------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
         -- ----------------------------------------------
where    lower(name) in ('mendy', 'mendi', 'mendel', 'menachem')
  and    lower(gender) = 'm'
         -- ----------------------------------------------
group by year
)

select   *,
         -- ----------------------------------------------
         sum(number_of_names) over(
             order by year
             range between unbounded preceding and current row
         ) cumalitive_number_of_names,
         -- ----------------------------------------------
         sum(number_of_names) over() total_number_of_names,
         -- ----------------------------------------------
         round(
             (number_of_names / sum(number_of_names) over()) * 100,
             2
         ) year_pct_from_total
         -- ----------------------------------------------
from     year_level
order by year