--B''H--

-- 2 separate meaningful queries utilizing GROUP BY and HAVING
-- data set in mock-data-pets.sql

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
