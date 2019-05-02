--B''H--

/* left outer join `bigquery-public-data.noaa_severe_storms.hail_reports`
with `bigquery-public-data.noaa_severe_storms.wind_reports`
see if hail was reported with a wind report */

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

