--B''H--

-- Here are some queries I think may lead to interesting ideas

select   description,
         count(*)
         -- --------------------------------------
from     `bigquery-public-data.austin_crime.crime`
         -- --------------------------------------
group by description
order by 2 desc

-- percentage of arrests for particular crimes

with 
arrests as
(
select   description,
         count(*) arrests_crime
         -- ---------------------------------------
from     `bigquery-public-data.chicago_crime.crime`
         -- --------------------------------------- 
where    arrest = true
         -- ---------------------------------------
group by description, arrest
         -- ---------------------------------------
order by 3 desc
)

select   *,
         round(
            (arrests_crime / sum(arrests_crime) over()) * 100,
            2
         ) percent_total
from     arrests

-- -------------------------------------------------------------------

select   classification,
         voluntary_mandated,
         count(*)
from     `bigquery-public-data.fda_food.food_enforcement` 
group by classification, voluntary_mandated
order by 1


select   *
from     `bigquery-public-data.noaa_hurricanes.hurricanes` 
order by season

-- -----------------------------------------------------------------------------

