--B''H--

with

first as
(
select   year 
from     unnest(generate_array(1910, 2018)) as year
),

second as
(
select   year
from     `bigquery-public-data.usa_names.usa_1910_current`
         -- -----------------------------------------------------
where    lower(name)  in ('mendy', 'mendi', 'mendel', 'menachem')
  and    lower(gender) = 'm'
),


third as
(
select   gen.year  gen_year,
         real.year names_year,
         -- -------------------------------------------------
         count(*) over(
             partition by real.year
             rows between unbounded preceding and current row
         ) island,
         -- -------------------------------------------------
         count(*) over() total_null
         -- -------------------------------------------------
from     first gen
    left outer join second real
      on gen.year = real.year
group by gen.year, real.year
)

select   *
from     third
where    island > 1