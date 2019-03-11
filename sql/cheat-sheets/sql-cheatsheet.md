# B''H

## [Main BigQuery Reference](https://cloud.google.com/bigquery/docs/reference/standard-sql/functions-and-operators)

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
       field_name,   -- parameter 1: string we're searching in
       'abc'        -- find the position of these characters
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