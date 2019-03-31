-- B''H --

select   states.state_name,
         usa_names.gender,
         usa_names.name,
         sum(usa_names.number) number_of_babies
from     `bigquery-public-data.usa_names.usa_1910_current` usa_names
         -- ------------------------------------------------------
   left outer join `data-science-course-226116.sql_lessons.states` states
     on usa_names.state = states.state_abbreviation
         -- ------------------------------------------------------
group by states.state_name, usa_names.gender, usa_names.name
having   number_of_babies > 370000
order by number_of_babies desc