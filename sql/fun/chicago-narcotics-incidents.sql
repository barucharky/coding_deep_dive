--B''H--

with 
narcs as
(
select   description,
         arrest,
         -- ------------------------------------------------------
         count(*) over(partition by description) num_incidents,
         count(*) over()                         total_incidents,
         -- ------------------------------------------------------
         case arrest 
              when true
              then count(*) over(partition by description, arrest) 
         end                                     num_arrests
         -- ------------------------------------------------------
from     `bigquery-public-data.chicago_crime.crime` 
         -- ------------------------------------------------------
where    lower(primary_type) like 'narcotics'
)

/*
total_incidents                total number of incidents where the primary_type is narcotics 
                               incidents that did not result in an arrest are included

description                    type of crime

percent_of_total_incidents     percentage incidents with that description

num_incidents                  total number of incidents with that description

num_arrests                    total number of incidents with that description that resulted in arrests

percent_incidents_arrest_true  percent incidents with that description that resulted in arrests

*/

select   distinct total_incidents,
         description,
         round(num_incidents / total_incidents * 100, 2) percent_of_total_incidents,
         num_incidents,
         num_arrests,
         round(num_arrests / num_incidents * 100, 2)     percent_incidents_arrest_true
         -- ------------------------------------------------------
from     narcs
         -- ------------------------------------------------------
where    arrest = true
         -- ------------------------------------------------------
order by 3 desc