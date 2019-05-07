--B''H--

select zip_code, area_land_meters, area_water_meters, state_code, city, county, internal_point
from `bigquery-public-data.geo_us_boundaries.us_zip_codes`

-- ------------------------------------------------------------
with
-- cities with the most zip codes
most_zips_city as
(
select   city,
         count(*) zip_codes,
         max(state_name) states
         -- -----------------------------------------------
from     `bigquery-public-data.geo_us_boundaries.us_zip_codes`
         -- -----------------------------------------------
group by city
having   count(*) > 1
         -- -----------------------------------------------
order by 2 desc
)

-- -------------------------------------------------------------

-- biggest area zip codes
biggest_zips as
(
select   zip_code,
         area_land_meters + area_water_meters total_area,
         city,
         state_code,
         internal_point,
         area_land_meters,
         area_water_meters
         -- ----------------------------------------------
from     `bigquery-public-data.geo_us_boundaries.us_zip_codes`
order by total_area desc
)

-- -------------------------------------------------------------

-- states with the most cities containing multiple zip codes
select   states,
         count(*) cities_mult_zips
from     most_zips_city
group by states
order by 2 desc



-- cities with their smallest area zip codes
least_area as
(
select   big.city city,
         big.total_area / most.zip_codes area_zip
         -- ----------------------------
from     most_zips_city     most
   inner join biggest_zips  big
      on most.city = big.city
order by area_zip
)

select   city,
         count(*) zips,
         min(area_zip) smallest_zip
         -- ------------------------
from     least_area
group by city
order by 3