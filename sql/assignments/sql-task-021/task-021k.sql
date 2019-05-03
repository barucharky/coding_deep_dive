--B'H--

-- number one is best ranked of its species
select   id,
         species,
         -- --------------------
         dense_rank() over(
             partition by species
             order by   csr desc
             ) species_csr_rank,
         -- --------------------
         csr,
         weight_in_kilos
         -- --------------------
from     animals