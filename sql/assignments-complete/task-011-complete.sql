-- B''H --

select   substr(account, 1, 1) account_char_1,
         avg(cost)             avg_cost,
         min(cost)             min_cost,
         max(cost)             max_cost,
         max(cost) - min(cost) cost_range
         -- --------------------------------------------------------
from     `data-science-course-226116.sql_lessons.group_by_sandbox`
         -- --------------------------------------------------------
where    impressions between 4 and 8
  and    cost > 5
         -- --------------------------------------------------------
group by account_char_1
         -- --------------------------------------------------------
having   avg_cost > 9
         -- --------------------------------------------------------
order by account_char_1