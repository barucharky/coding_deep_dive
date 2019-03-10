select 
       -- ------------------------------------------
       case
          when lower(county_name) like '%city%' then
          substr(county_name,1,
              strpos(lower(county_name),'city') - 1
              )
          when lower(county_name) like '%county%' then
             substr(county_name,1,
                strpos(lower(county_name),'county') - 1
                )
          else county_name
       end county_plain,
        -- ------------------------------------------
       substr(county_name,1,1) first_char,
        -- ------------------------------------------
       cast(county_fips_code as int64) fips_code
       -- -------------------------------------------
from `data-science-course-226116.sql_lessons.counties`
where lower(substr(state_abbreviation,1,1)) in ('a','d','n','o','p')
order by county_fips_code
