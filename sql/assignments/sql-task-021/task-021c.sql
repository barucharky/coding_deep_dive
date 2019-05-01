--B''H--

-- 1 meaningful query that has AND and OR used simultaneously in the HAVING clause
-- data set in mock-data-pets.sql

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
