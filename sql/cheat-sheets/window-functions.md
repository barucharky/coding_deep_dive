# B''H

## Window Functions

---

Also refered to as `analytic functions`.
Used to analyze and aggregate data over a group of rows. Any aggregate function can be used -- avg(), sum(), min(), max(), string_agg(), etc. 

---

## How it's done

### Syntax:
```sql
analytic_function_name ( [ argument_list ] )
  OVER (
    [ PARTITION BY partition_expression_list ]
    [ ORDER BY expression [{ ASC | DESC }] [, ...] ]
    [ window_frame_clause ]
  )
```

---

### Examples:

#### `row_number()`, `rank()`, and `dense_rank()` are often used to assign numbers to rows

- `row_number() over(order by v)` assigns a unique number to each row within the partition
   | V | ROW_NUMBER |
   |---|------------|
   | a |          1 |
   | a |          2 |
   | a |          3 |
   | b |          4 |
   | c |          5 |
   | c |          6 |
   | d |          7 |
   | e |          8 |

- `rank() over(order by v)` assigns rows of equal value the same rank and there a gaps between the ranks
   | V | RANK |
   |---|------|
   | a |    1 |
   | a |    1 |
   | a |    1 |
   | b |    4 |
   | c |    5 |
   | c |    5 |
   | d |    7 |
   | e |    8 | 

- `dense_rank() over(order by v)` does the same thing without gaps
   | V | DENSE_RANK |
   |---|------------|
   | a |          1 |
   | a |          1 |
   | a |          1 |
   | b |          2 |
   | c |          3 |
   | c |          3 |
   | d |          4 |
   | e |          5 |

---

# RANGE vs ROWS

**RANGE** operates logically relative to the current value, whereas the 
**ROWS** clause operates physically on rows of the table

### Example

The following query:

```sql
with mock_data as
(
select  1  day_seq, 1.0 amt union all
select  2  day_seq, 1.0 amt union all
select  2  day_seq, 1.0 amt union all
select  3  day_seq, 1.0 amt union all
select  6  day_seq, 1.0 amt union all
select  7  day_seq, 1.0 amt union all
select  9  day_seq, 1.0 amt union all
select  10 day_seq, 1.0 amt 
)
-- ----------------------------------------------------------
select   day_seq,
         amt,                
         -- -------------------------------------------------
         sum(amt) over (             
             order by      day_seq
             range between 2 preceding and current row
         ) moving_sum_3_day,    
         -- -------------------------------------------------
         sum(amt) over (             
             order by      day_seq
             rows between 2 preceding and current row
         ) moving_sum_3_rows     
         -- -------------------------------------------------
from     mock_data
         -- -------------------------------------------------
order by day_seq
```

Gives you this table:

|Row|day_seq|amt|moving_sum_3_day|moving_sum_3_rows|
|---|---|---|---|---|
|1|1|1.0|1.0|1.0|
|2|2|1.0|3.0|2.0|
|3|2|1.0|3.0|3.0|
|4|3|1.0|4.0|3.0|
|5|6|1.0|1.0|3.0|
|6|7|1.0|2.0|3.0|
|7|9|1.0|2.0|3.0|
|8|10|1.0|2.0|3.0|


[Helpful blog about range vs rows](https://sonra.io/2017/08/22/window-function-rows-and-range-on-redshift-and-bigquery/)