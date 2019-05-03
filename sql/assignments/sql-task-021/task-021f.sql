--B''H--

-- National Oceanic and Atmospheric Administration reports of hail, wind when relevant 
select   hail.size      hail_size,
         hail.location  hail_location,
         hail.county    hail_county,
         hail.state     hail_state,
         hail.latitude  hail_latitude,
         hail.longitude hail_longitude,
         hail.comments  hail_comments,
         -- --------------------------------------------------------
         wind.speed     wind_speed,
         wind.location  wind_location,
         wind.county    wind_county,
         wind.state     wind_state,
         wind.latitude  wind_latitude,
         wind.longitude wind_longitude,
         wind.comments  wind_comments
from     `bigquery-public-data.noaa_severe_storms.hail_reports` hail
    left outer join `bigquery-public-data.noaa_severe_storms.wind_reports` wind
      on hail.location = wind.location


with
employees as
(
select   1  id, "Keri Weiser"      full_name union all
select   2  id, "Cole Kobel"       full_name union all
select   3  id, "Mallie Molock"    full_name union all
select   4  id, "Tamiko Somma"     full_name union all
select   5  id, "Gayle Laraway"    full_name union all
select   6  id, "Billi Giddings"   full_name union all
select   7  id, "Kaitlin Tillmon"  full_name union all
select   8  id, "Corie Scheu"      full_name union all
select   9  id, "Chantell Faires"  full_name union all
select   10 id, "Brandon Martir"   full_name union all
select   11 id, "Betsy Gautier"    full_name union all
select   12 id, "Risa Buxton"      full_name union all
select   13 id, "Blythe Mcilvaine" full_name union all
select   14 id, "Mistie Roza"      full_name union all
select   15 id, "Laquanda Langsam" full_name union all
select   16 id, "Elroy Parfait"    full_name union all
select   17 id, "Susanne Sistrunk" full_name union all
select   18 id, "Candace Savino"   full_name union all
select   19 id, "Erich Wedgeworth" full_name union all
select   20 id, "Lesli Luper"      full_name 
),

layoffs as
(
select   1  id, "terminated" emp_status union all
select   3  id, "terminated" emp_status union all
select   5  id, "terminated" emp_status union all
select   6  id, "terminated" emp_status union all
select   7  id, "terminated" emp_status union all
select   8  id, "terminated" emp_status union all
select   9  id, "terminated" emp_status union all
select   11 id, "terminated" emp_status union all
select   13 id, "terminated" emp_status union all
select   14 id, "terminated" emp_status union all
select   16 id, "terminated" emp_status union all
select   18 id, "terminated" emp_status union all
select   19 id, "terminated" emp_status
)

select   emp.id emp_id,
         emp.full_name name,
         lay.emp_status update
         -- ---------------------
from     employees emp
    left outer join layoffs lay
      on emp.id = lay.id