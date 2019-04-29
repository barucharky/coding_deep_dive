--B''H--
               
select   description,
         count(*)
         -- --------------------------------------
from     `bigquery-public-data.austin_crime.crime`
         -- --------------------------------------
group by description
order by 2 desc



select   classification,
         voluntary_mandated,
         count(*)
from     `bigquery-public-data.fda_food.food_enforcement` 
group by classification, voluntary_mandated
order by 1


select   *
from     `bigquery-public-data.noaa_hurricanes.hurricanes` 
order by season