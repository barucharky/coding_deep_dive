--B''H--

with

digits as
(
select   0 digit union all
select   1 digit union all
select   2 digit union all
select   3 digit union all
select   4 digit union all
select   5 digit union all
select   6 digit union all
select   7 digit union all
select   8 digit union all
select   9 digit
)

select   d3.digit * 100 + d2.digit * 10 + d1.digit + 1 numbers
from     digits d1
 cross join digits d2
 cross join digits d3
order by 1