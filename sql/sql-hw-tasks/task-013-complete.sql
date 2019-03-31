-- B''H --

select   c.county_name,
         c.fips_class_code,
         c.state_abbreviation
         -- ------------------------------------------
from     `data-science-course-226116.sql_lessons.join_test_counties` c
   left outer join `data-science-course-226116.sql_lessons.join_test_states` s
     on c.state_abbreviation = s.state_abbreviation
         -- ------------------------------------------
where    s.state_name is null
  and    lower(c.county_name) like '%ada%'