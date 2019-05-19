# B"H


## GROUP BY Walk-through

---

### Synonyms in SQL to keep in mind:
- row, record, line
- column, field, attribute


---

```sql

-- -----------------------------------------------------------------------
-- level-of-grain: ??????? Mendy, find out :)
--
-- there are 277,036 records
select   account, 
         campaign, 
         cost,
         impressions 
from    `data-science-course-226116.sql_lessons.group_by_sandbox` 
-- -----------------------------------------------------------------------


-- -----------------------------------------------------------------------
-- level-of-grain: campaign
--
-- 45 distinct campaigns
select  distinct campaign         
from    `data-science-course-226116.sql_lessons.group_by_sandbox` 
-- -----------------------------------------------------------------------


-- -----------------------------------------------------------------------
-- level-of-grain: account
--
-- 169 distinct accounts
select  distinct account         
from    `data-science-course-226116.sql_lessons.group_by_sandbox` 
-- -----------------------------------------------------------------------


-- -----------------------------------------------------------------------
-- level-of-grain: account/campaign
--
-- 210 distinct account/campaign
--
-- note how it doesn't need to add up from prior two steps
-- because campaigns can share the same account and vice-versa
select  distinct account, campaign        
from    `data-science-course-226116.sql_lessons.group_by_sandbox` 
-- -----------------------------------------------------------------------

```


---



### Step 1 - FROM
- Number of records: 277,036
- Columns in the "table" that gets passed to step 2
    1. account
    2. campaign
    3. cost
    4. impressions

```sql

from  `data-science-course-226116.sql_lessons.group_by_sandbox` 


```


---


### Step 2 - WHERE
- Number of records: 34,938
- Columns in the "table" that gets passed to step 3
    1. account
    2. campaign
    3. cost
    4. impressions

```sql

where   cost > 5.5

```


---

### Step 3 - GROUP BY 
- Number of records: 43
- Columns in the "table" that gets passed to step 4
    1. Any ***GROUP BY*** column(s) - which are the ***Level-of-Grain*** column(s)
    2. Any column from step 2 above **as long** as you aggregate it
    

```sql

group by campaign 

```


---


### Step 4 - HAVING 
- Number of records: 14

- Columns that can be used in the HAVING clause:
    - Any column from step 2 above **as long** as you aggregate it

- Columns in the "table" that gets passed to step 5
    1. Any ***GROUP BY*** column(s) - which are the ***Level-of-Grain*** column(s)
    2. Any column from step 2 above **as long** as you aggregate it
    

```sql

having   sum(cost) > 1000
   and   avg(cost) > 8

```

---


### Step 5 - SELECT 
- Number of records: 14

- Columns that can be used in the SELECT clause:
    1. Any ***GROUP BY*** column(s) - which are the ***Level-of-Grain*** column(s)
    2. Any column from step 2 above **as long** as you aggregate it

- Columns in the "table" that gets passed to step 6
    1. Any ***GROUP BY*** column(s) - which are the ***Level-of-Grain*** column(s)
    2. Any column from step 2 above **as long** as you aggregate it
    

```sql

group by campaign 

```


---

### Step 6 - ORDER BY 
- Number of records: 14

- Columns that can be used in the ORDER BY clause:
    1. Any ***GROUP BY*** column(s) - which are the ***Level-of-Grain*** column(s)
    2. Any column from step 2 above **as long** as you aggregate it

- Note if you order by any column that is in the SELECT, you can use the alias instead    

```sql

order by sum_impressions_per_campaign

```

---

## Final SQL Query:

```sql


-- step 5:
select   campaign,
         sum(cost)               sum_cost_per_campaign,
         avg(cost)               avg_cost_per_campaign,
         sum(impressions)        sum_impressions_per_campaign,
         -- ------------------------------------------------------
         count(*)                number_of_records,
         count(account)          number_of_accounts, -- just use count(*) if you want number of records
         count(distinct account) number_of_distinct_accounts
         
-- step 1:
from     `data-science-course-226116.sql_lessons.group_by_sandbox` 
-- step 2:
where    cost > 5.5
-- step 3:
group by campaign 
-- step 4:
having   sum(cost) > 1000
   and   avg(cost) > 8
-- step 6:
order by sum_impressions_per_campaign

```