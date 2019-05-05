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
current_and_next as
(
select   year current_year_in_cte,
         -- ----------------------------------------------------- 
         lead(year) over (order by year) next_year_in_cte
         -- -----------------------------------------------------
from     years
)
-- --------------------------------------------------------------
select   current_year_in_cte,
         next_year_in_cte,
         -- -----------------------------------------------------
         current_year_in_cte + 1  water_gap_start,
         next_year_in_cte    - 1  water_gap_end,
         -- -----------------------------------------------------
         next_year_in_cte - current_year_in_cte - 1  total_water_gap
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
year_ranks as
(
select   year,
         -- ----------------------------------------------------- 
         dense_rank() over (order by year) year_rank
         -- -----------------------------------------------------
from     years
),
-- --------------------------------------------------------------
island_identifiers as
(
select   year,
         year_rank,
         year - year_rank island_identifier
from     year_ranks
)
-- --------------------------------------------------------------
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
