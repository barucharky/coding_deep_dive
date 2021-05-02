select   *
from     `bigquery-public-data.geo_us_boundaries.zip_codes`


select   zip_code,
         count(*) city

from     `bigquery-public-data.geo_us_boundaries.zip_codes`
group by zip_code
having   count(*) > 1
order by city desc

-- biggest and smallest areas with the same zip code
with
area_rows as
(
select   zip_code,
         city,
         state_name,
         area_land_meters,
         row_number() over (order by area_land_meters desc) area_land_meters_desc,
         row_number() over (order by area_land_meters) area_land_meters_asc
from     `bigquery-public-data.geo_us_boundaries.zip_codes`
)

select   b.zip_code,
         b.city,
         b.state_name,
         b.area_land_meters,
         l.zip_code,
         l.city,
         l.state_name,
         l.area_land_meters
from     area_rows b
   inner join area_rows l
      on b.area_land_meters_asc = l.area_land_meters_desc
where    b.area_land_meters_desc < 4

-- number of zip codes by county
select   county,
         state_name,
         count(*) num_zip_codes
from     `bigquery-public-data.geo_us_boundaries.zip_codes`
where    county <> ""
group by county, state_name
order by num_zip_codes desc

