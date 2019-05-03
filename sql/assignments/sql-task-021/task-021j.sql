--B''H--


-- if I hadn't already made an id, it could be done like this
select   row_number() over(), id
         species,
         temperment,
         csr
         -- -----------------------
from     animals