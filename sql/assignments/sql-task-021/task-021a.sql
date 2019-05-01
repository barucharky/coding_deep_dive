--B''H--

-- 2 separate meaningful queries that have AND and OR used simultaneously in the WHERE clause
-- data set in mock-data-pets.sql

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
