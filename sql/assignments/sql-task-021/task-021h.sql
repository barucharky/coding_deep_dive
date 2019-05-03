--B''H--

/* There is limited information on this data set. I'm assuming the value of the debt is not 
accumulative, but likely it is */

select   country_name,
         value,
         year,
         -- -------------------------
         sum(value) over(partition by country_name) total_country_debt,
         sum(value) over(partition by) total_world_debt
         -- -----------------------------------------------
from `bigquery-public-data.world_bank_intl_debt.international_debt`