--B''H--

/*
Not sure if I'm doing this right, but this is supposed to sign a hash to each record 
that the following query produces. If this data set is updated often, this hash can 
be used to track cases that meet this criteria
*/

select   *,
         -- ---------------------------------------------
         to_hex(
             sha512(
                 cat(coalesce(classification, '<classification field>')
                     coalesce(voluntary_mandated, '<voluntary_mandated field>')
                     coalesce(status, '<status field>')
                 )
             )
         )
         -- ---------------------------------------------
from     `bigquery-public-data.fda_food.food_enforcement` 
         -- ---------------------------------------------
where    lower(classification)     like 'class i'
  and    lower(voluntary_mandated) like 'fda mandated'
  and    lower(status)             like 'ongoing'
         -- ---------------------------------------------
order by 1

/*Maybe it's more usefull just to do this. My intention with the above query is that only
records that match the `where` clause will have hashes*/

select   *,
         -- ---------------------------------------------
         to_hex(
             sha512(
                 cat(coalesce(classification, '<classification field>')
                     coalesce(voluntary_mandated, '<voluntary_mandated field>')
                     coalesce(status, '<status field>')
                 )
             )
         )
         -- ---------------------------------------------
from     `bigquery-public-data.fda_food.food_enforcement` 

/*
Salting passwords. The following list of passwords are hashed and then salted for further
security.

most of passwords are from the wikipedia list:
https://en.wikipedia.org/wiki/List_of_the_most_common_passwords
*/


with 
salty as
(
select   'password'  password union all
select   'please'    password union all
select   'admin'     password union all
select   'Admin'     password union all
select   'letmein'   password union all
select   '123456'    password union all
select   '!@#$%^&*'  password union all
select   'qwerty'    password union all
select   'welcome'   password union all
select   'gerald'    password union all
select   'd5f1a85d4' password 
)

select   *,
         -- ---------------------
         to_hex(
            sha512(
               password
            ) 
         ) reg_hash,
         -- ---------------------
         to_hex(
            sha512(
                concat(
                   to_hex(
                      sha512(
                        password
                      )
                   ), 'abc123'
                )
            )
         ) salted_hash
         -- ---------------------
from     salty