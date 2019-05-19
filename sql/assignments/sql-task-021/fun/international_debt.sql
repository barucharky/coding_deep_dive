-- B''H --

-- I don't undersand why China has records with different values in the same year

select   debt.country_name,
         summ.region,
         summ.currency_unit,
         debt.value,
         debt.year
         -- -------------------------------------------------------
from     `bigquery-public-data.world_bank_wdi.country_summary` summ
         -- -------------------------------------------------------
   inner join `bigquery-public-data.world_bank_intl_debt.international_debt` debt
         on summ.country_code = debt.country_code
         -- -------------------------------------------------------
where    summ.region not like ''
  and    debt.value > 0
  and    debt.year = 2018
         -- -------------------------------------------------------
order by debt.value desc
         -- -------------------------------------------------------
limit    10


-- Trying to figure out if records with no `region` are junk data

select   distinct debt.country_name
from     `bigquery-public-data.world_bank_wdi.country_summary` summ
   inner join `bigquery-public-data.world_bank_intl_debt.international_debt` debt
         on summ.country_code = debt.country_code
where    summ.region like ''
order by debt.country_name

/*
I'm pretty sure it is because the following country names aren't specific to any year or region

East Asia & Pacific (excluding high income)
Europe & Central Asia (excluding high income)
IDA only
Latin America & Caribbean (excluding high income)
Least developed countries: UN classification
Low & middle income
Low income
Lower middle income
Middle East & North Africa (excluding high income)
Middle income
South Asia
Sub-Saharan Africa (excluding high income)
Upper middle income

*/