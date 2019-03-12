# B''H

## [Main BigQuery Reference](https://cloud.google.com/bigquery/docs/reference/standard-sql/functions-and-operators)

---

## Written Order

```sql
select  
from 
where 
group by 
having 
order by 
```

### Note that the logical order places `select` below `having`, above `order by`
---

## Editing strings

## `substr`

```sql
substr(
       time_zone,            -- parameter 1: string we're going to disect
       1,                    -- parameter 2: position to start from
       ending_dash_position  -- parameter 3: how many charachters to go for 
      )
```

## `strpos`

```sql
strpos(
       field_name,    -- parameter 1: string we're searching in
       'abc'          -- find the position of these characters
)
```

## `replace`
- replace characters within a string

```sql
replace(
        field_name,   -- string we're working with
        'abc',        -- characters to replace
        'xyz'         -- characters to replace with
)
```

---

## `case`
- Acts as an `IF` statement

```sql
case cast(substr(fips_class_code, 2, 1) as int64)
    when 1 then 'One'
    when 2 then 'Two'
    when 3 then 'Three'
    when 4 then 'Four'
    when 5 then 'Five'
    when 6 then 'Six'
    when 7 then 'Seven'
end char2_desc
```

---

## `safe_cast`
- converts data from one type to another without producing an error

```sql
safe_cast(
          expr          -- the field you want to convert
          as typename   -- the type you want to convert to (int64, numeric, string, date, etc)
)
```

---

## `where` clause

#### example:
```sql
select   *
from     customers
where    country is 'Mexico'
```

---

## Operators
|Operator|Description|
|---|---|
|=|Equal (you can use 'is' instead) |
|<>|Not equal. Note: In some versions of SQL this operator may be written as !=|
|>|Greater than|
|<|Less than|
|>=|Greater than or equal|
|<=|Less than or equal|
|BETWEEN|Between a certain range|
|LIKE|Search for a pattern where `%` is wildcard|
|IN|To specify multiple possible values for a column ('a','b','c') |

## Data types
|description|type|example|
|---|---|---|
|string|string|'Hello World!', '00012'|
|integer|int64|12|
|numeric|numeric|123.01, 12.9090|
|date|date|'2019-03-20'|
|time|time|'14:02:03'|
|datetime|datetime|'2019-03-20 14:02:03'|