# B''H


## SQL Task 19 - Finding ***water gaps*** and ***islands***

---

### The objective of this task is to understand how all the below queries work.
- Note;
    - This is considered **advanced** SQL so do not worry if it takes a while to "sink in"
    - Go thru the `CTE's` step by step to see what each step return by itself.
    - First understand what each `CTE` step does on its own and only after see how the whole query works

---

#### Intro:
- Run the following query:

```sql

select   distinct year         
         -- -----------------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
         -- -----------------------------------------------------
where    lower(name)  in ('mendy', 'mendi', 'mendel', 'menachem')
  and    lower(gender) = 'm'
order by 1  

```

- Output:

|year|
|---|
|1914|
|1924|
|1925|
|1929|
|1948|
|1949|
|1950|
|1951|
|1952|
|1953|
|1954|
|1955|
|1956|
|1957|
|1958|
|1959|
|1960|
|1961|
|1963|
|1964|
|1965|
|1966|
|1967|
|1968|
|1969|
|1970|
|1971|
|1972|
|1973|
|1974|
|1975|
|1976|
|1977|
|1978|
|1979|
|1980|
|1981|
|1982|
|1983|
|1984|
|1985|
|1986|
|1987|
|1988|
|1989|
|1990|
|1991|
|1992|
|1993|
|1994|
|1995|
|1996|
|1997|
|1998|
|1999|
|2000|
|2001|
|2002|
|2003|
|2004|
|2005|
|2006|
|2007|
|2008|
|2009|
|2010|
|2011|
|2012|
|2013|
|2014|
|2015|
|2016|
|2017|

---

- Notice, how there's gaps in the data. For example; 
    - between `1914` and `1924` there are no records
    - between `1925` and `1929` there are no records
    - etc.

---

### The goal of this task is to find those ***gaps*** and ***islands***.
- Imagine all the years between `1914` and `2017` as water
- Imagine all the years that actually have a record here as ***islands***
- If we then canoe thru the years it appears like this:
    - `1914` is a **1** year ***island***
    - `1915` thru `1923` is a **9** year ***water gap***
    - `1924` thru `1925` is a **2** year ***island***
    - `1926` thru `1928` is a **3** year ***water gap***
    - etc. 

---

## Here is the query to find the ***water gaps***:

The following will produce the very long table shown above. It's a list of each year that has at least one of the names listed in the `where` clause. Note that there are some consecutive years and some years that are skipped. The years that are skipped are our 'water gaps' that we are trying to find.

```sql

with years as
(
-- Level-of-grain of this CTE is: year
select   distinct year         
         -- -----------------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
         -- -----------------------------------------------------
where    lower(name)  in ('mendy', 'mendi', 'mendel', 'menachem')
  and    lower(gender) = 'm'
         -- -----------------------------------------------------
),
-- --------------------------------------------------------------
```

This next CTE produces a table just like the last one, only 'year' is renamed 'current_year_in_cte' and there is a second column called 'next_year_in_cte' which gives the year in the data set that comes next.

It will look like this, only longer:

|current_year_in_cte|next_year_in_cte|
|---|---|
|1914|1924|
|1924|1925|
|1925|1929|
|1929|1948|
|1948|1949|
|1949|1950|
|1950|1951|
etc.

```sql
current_and_next as
(
select   year current_year_in_cte,
         -- ----------------------------------------------------- 
         lead(year) over (order by year) next_year_in_cte
         -- -----------------------------------------------------
from     years
)
```

The last part takes the table we just made in current_and_next and finds the 'water gaps'

The `where` clause limits the data to include only years that are not consecutive. Then it follows that current_year_in_cte will always be the year before a gap and next_year_in_cte will be the year after that gap. The rest of it is basic math to show the first and last year in the gap and the total number of years in that gap.

```sql
-- --------------------------------------------------------------
select   current_year_in_cte,  -- Gap starts after this year
         next_year_in_cte,     -- Gap ends before this year
                               -- current_year_in_cte and next_year_in_cte both meet our criteria. The ones in between don't
         -- -----------------------------------------------------
         current_year_in_cte + 1  water_gap_start,  -- first year of the water gap (i.e. that doesn't meet the criteria)
         next_year_in_cte    - 1  water_gap_end,    -- last year of that water gap 
         -- -----------------------------------------------------
         next_year_in_cte - current_year_in_cte - 1  total_water_gap  -- total number of years in each gap
         -- -----------------------------------------------------
from     current_and_next 
where    next_year_in_cte - current_year_in_cte > 1
order by 1

```

- Output:

|current_year_in_cte|next_year_in_cte|water_gap_start|water_gap_end|total_water_gap|
|---|---|---|---|---|
|1914|1924|1915|1923|9|
|1925|1929|1926|1928|3|
|1929|1948|1930|1947|18|
|1961|1963|1962|1962|1|


---

## Here is the query to find the ***islands***:

The 'islands' here are all the consecutive years that meet our criteria of having the names we selected.

Again, the first part produces that whole list of years, some of them consecutive, some of them not. 

The plan here is to put all the years into groups of consecutive years. This way we can refer to a group of years and say that the lowest or minimum year in that group is the beginning of an island and the highest or maximum year is the end of that island.

This means that each group of years that run consecutively must share a unique ID so that when we put that ID in our `group by` clause, we can produce the lowest and highest number in that group.

```sql

with years as
(
-- Level-of-grain of this CTE is: year
select   distinct year         
         -- -----------------------------------------------------
from     `bigquery-public-data.usa_names.usa_1910_current`
         -- -----------------------------------------------------
where    lower(name)  in ('mendy', 'mendi', 'mendel', 'menachem')
  and    lower(gender) = 'm'
         -- -----------------------------------------------------
),
-- --------------------------------------------------------------
```

This first step after the original query gives each row a number. Now the first column will have the entire list of years and the second column will have a list of consecutive numbers. It will look like the following table only longer:

|year|year_rank|
|---|---|
|1914|1|
|1924|2|
|1925|3|
|1929|4|
|1948|5|
|1949|6|
|1950|7|
etc.

Don't worry if you don't see why we did this yet. It will become more clear in the next step.

```sql
year_ranks as
(
select   year,
         -- ----------------------------------------------------- 
         dense_rank() over (order by year) year_rank
         -- -----------------------------------------------------
from     years
),
-- --------------------------------------------------------------
```

Now we subtract the second column from the first column. Since the second column numbers are increasing by increments of one, consecutive years will produce the same number since they also increase by increments of one. Non-consecutive years will have a different number. Now we have an number to identify our 'island' or groups of consecutive years that meet our criteria!

It will look like this:

|year|year_rank|island_identifier|
|---|---|---|
|1914|1|1913|
|1924|2|1922|
|1925|3|1922|
|1929|4|1925|
|1948|5|1943|
|1949|6|1943|
|1950|7|1943|

See how the consecutive years have the same island_identifier column?

```sql
island_identifiers as
(
select   year,
         year_rank,
         year - year_rank island_identifier
from     year_ranks
)
-- --------------------------------------------------------------
```

Now all we have to do is group all the data by that island_identifier and get the minimum and maximum value of that group.

For example the years 1924 and 1925 both have the island_identifier 1922. Since they are the only years in that group, they are the minimum and maximum numbers in that group. They will be listed as the beginning and end of that island.

```sql
select   min(year) island_begining,
         max(year) island_ending
from     island_identifiers 
group by island_identifier
order by 1

```

- Output:

|island_begining|island_ending|
|---|---|
|1914|1914|
|1924|1925|
|1929|1929|
|1948|1961|
|1963|2017|

If you look back, you'll see that 1948 is in a group of years that have the island_identifier value of 1943. It's a big island. It goes all the way up to 1961, meaning there are consecutive years from 1948 to 1961 that meet our criteria.