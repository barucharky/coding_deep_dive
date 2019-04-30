--B''H--

-- Here are some queries I think may lead to interesting ideas

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

-- -----------------------------------------------------------------------------

-- mock data about pet adoption. csr is child safety rating

with 
animals as
(
select   '1'  id, 'dog'    species, 'active'    temperment, 8.3 csr, 3.8 weight_in_kilos union all
select   '2'  id, 'dog'    species, 'calm'      temperment, 8.9 csr, 6.3 weight_in_kilos union all
select   '3'  id, 'cat'    species, 'energetic' temperment, 7.4 csr, 2   weight_in_kilos union all
select   '4'  id, 'cat'    species, 'angry'     temperment, 4.9 csr, 3.5 weight_in_kilos union all
select   '5'  id, 'cat'    species, 'calm'      temperment, 8.6 csr, 2.9 weight_in_kilos union all
select   '6'  id, 'cat'    species, 'calm'      temperment, 7.2 csr, 2.8 weight_in_kilos union all
select   '7'  id, 'rabbit' species, 'calm'      temperment, 9.1 csr, 2.4 weight_in_kilos union all
select   '8'  id, 'rabbit' species, 'calm'      temperment, 9.3 csr, 2.8 weight_in_kilos union all
select   '9'  id, 'rabbit' species, 'calm'      temperment, 9.4 csr, 2.6 weight_in_kilos union all
select   '10' id, 'cat'    species, 'calm'      temperment, 7.8 csr, 3.2 weight_in_kilos union all
select   '11' id, 'cat'    species, 'energetic' temperment, 6.7 csr, 2.6 weight_in_kilos union all
select   '12' id, 'ferret' species, 'active'    temperment, 5.4 csr, 0.5 weight_in_kilos union all
select   '13' id, 'dog'    species, 'active'    temperment, 7.7 csr, 4.1 weight_in_kilos union all
select   '14' id, 'dog'    species, 'active'    temperment, 7.6 csr, 4.9 weight_in_kilos union all
select   '15' id, 'rat'    species, 'calm'      temperment, 9.1 csr, 0.2 weight_in_kilos union all
select   '16' id, 'rat'    species, 'calm'      temperment, 9.5 csr, 0.3 weight_in_kilos union all
select   '17' id, 'rat'    species, 'active'    temperment, 9.2 csr, 0.1 weight_in_kilos union all
select   '18' id, 'dog'    species, 'calm'      temperment, 9.6 csr, 3.6 weight_in_kilos union all
select   '19' id, 'dog'    species, 'active'    temperment, 7.6 csr, 9.6 weight_in_kilos union all
select   '20' id, 'goat'   species, 'active'    temperment, 6.9 csr, 7.4 weight_in_kilos union all
select   '21' id, 'dog'    species, 'playful'   temperment, 8.1 csr, 6.8 weight_in_kilos
)

-- 2 separate meaningful queries that have AND and OR used simultaneously in the WHERE clause

select   *
from     animals
         -- ------------------------------------------
where    species like 'dog' and (temperment like 'calm' or temperment like 'playful')
   or    species like 'cat'
order by 2

-- -----------------------------------------------------------------------------

select   *
from     animals
         -- ---------------------------------------
where    species like 'dog' and weight_in_kilos < 5
   or    species like 'rat'
   or    species like 'rabbit'
         -- ---------------------------------------
order by 2

-- 2 separate meaningful queries utilizing GROUP BY and HAVING

-- helps choose which species for a pet for children
select   species,
         avg(csr) avg_csr
         -- -------------------------
from     animals
         -- -------------------------
group by species
         -- -------------------------
  having avg(csr) > 8
         -- -------------------------
order by 2

-- max is used to find a species where all adoption options will be under a certain weight
select   species,
         max(weight_in_kilos) max_weight
         -- -------------------------
from     animals
         -- -------------------------
group by species
         -- -------------------------
  having max(weight_in_kilos) < 3
         -- -------------------------
order by 2

-- combination of the two
select   species,
         max(weight_in_kilos) max_weight
         -- -------------------------
from     animals
         -- -------------------------
group by species
         -- -------------------------
  having max(weight_in_kilos) < 3
     and avg(csr) > 8
         -- -------------------------
order by 2

-- 1 meaningful query that has AND and OR used simultaneously in the HAVING clause
select   species,
         avg(weight_in_kilos) avg_weight,
         max(weight_in_kilos) max_weight,
         min(csr) min_csr,
         avg(csr) avg_csr
         -- ------------------------------
from     animals
         -- ------------------------------
group by species
         -- ------------------------------
having   avg(csr) > 8 and min(csr) > 6
    or   max(weight_in_kilos) < 3

