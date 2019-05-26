# B''H 


## Tidy Data

#### Tidy datasets are:
1. Easy to manipulate
2. Model
3. Visualize

#### Tidy have a specific structure:
1. Each variable is a column
2. Each observation (event) is a row
3. Each type of observational unit is a table

---

```sql

select   'John Smith' name, null treatment_a_doses,  2  treatment_b_doses union all
select   'Jane Doe'   name, 16   treatment_a_doses,  11 treatment_b_doses union all
select   'Mosihy'     name, 3    treatment_a_doses,  1  treatment_b_doses 

```


```sql

select 'a' treatment_type, null john_smith, 16 jane_doe, 3 moishy union all
select 'b' treatment_type, 2    john_smith, 11 jane_doe, 1 moishy

```

```sql

select 'John Smith' name, 'a' treatment_type, null doses union all
select 'Jane Doe'   name, 'a' treatment_type, 16   doses union all
select 'Moishy'     name, 'a' treatment_type, 3    doses union all
select 'John Smith' name, 'b' treatment_type, 2    doses union all
select 'Jane Doe'   name, 'b' treatment_type, 11   doses union all
select 'Moishy'     name, 'b' treatment_type, 1    doses 

```





