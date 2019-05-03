--B''H--

select   id,
         species,
         -- -------------------------------
         csr,
         weight_in_kilos,
         -- -------------------------------
         round(avg(csr) over(partition by species), 2) avg_csr_species,
         round(avg(weight_in_kilos) over(partition by species), 2) avg_weight_species
         -- -------------------------------
from     animals