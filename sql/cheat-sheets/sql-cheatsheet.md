# B''H

## [Main BigQuery Reference](https://cloud.google.com/bigquery/docs/reference/standard-sql/functions-and-operators)

---

## `substr`

```sql
substr(
       time_zone,            -- parameter 1: string we're going to disect
       1,                    -- parameter 2: position to start from
       ending_dash_position  -- parameter 3: how many charachters to go for 
      )
```

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