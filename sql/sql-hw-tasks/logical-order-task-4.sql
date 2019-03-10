-- B''H --

/*
Show columns in result:
    - county name (up to 'city' or up to 'County')
    - first digit of the county name
    - county fips code (cast to integer)
    
where state abbreviation starts with a, d, n, o, p

order by county fips code
*/

SELECT   *  
FROM     `data-science-course-226116.sql_lessons.counties` 