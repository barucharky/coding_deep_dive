-- B''H --

select   s.state_abbreviation,
         s.state_name,
         count(c.county_name) number_of_counties
         -- -----------------------------------------------
from     `data-science-course-226116.sql_lessons.join_test_states` s
         -- -----------------------------------------------
   left outer join `data-science-course-226116.sql_lessons.join_test_counties` c
     on c.state_abbreviation = s.state_abbreviation
         -- -----------------------------------------------
group by s.state_abbreviation, s.state_name
         -- -----------------------------------------------

having count(c.county_name) > 140
    or count(c.county_name) < 2
         -- -----------------------------------------------
order by number_of_counties desc, s.state_abbreviation