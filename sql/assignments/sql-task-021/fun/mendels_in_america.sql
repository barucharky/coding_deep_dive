-- B''H --

with mm as
(
select   name,
         sum(number)                   occurances,
         min(safe_cast(year as int64)) first,
         max(safe_cast(year as int64)) last
         -- ----------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
         -- ----------------------------------------------
group by name
         -- ----------------------------------------------
having   lower(name) =    'menachem'
    or   lower(name) like 'mend%'
)

select   min(first)             first_occurance,
         max(last)              last_occurance,
         sum(occurances)        number_of_occurances,
         string_agg(name, ', ') variations
from     mm



-- Number of Baruchs

with mm as
(
select   name,
         sum(number)                   baruchs,
         min(safe_cast(year as int64)) first,
         max(safe_cast(year as int64)) last
         -- ----------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
         -- ----------------------------------------------
group by name
         -- ----------------------------------------------
having   lower(name) in ('baruch', 'boruch', 'borach', 'burech', 'burach')
)

select   min(first)             first_occurance,
         max(last)              last_occurance,
         sum(baruchs)           number_of_baruchs,
         string_agg(name, ', ') variations
from     mm