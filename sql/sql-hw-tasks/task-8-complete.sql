select   account,
         avg(cost) avg_cost_per_account,
         sum(cost) sum_cost_per_account
from `data-science-course-226116.sql_lessons.group_by_sandbox`
where   impressions > 2
group by account
having   avg(cost) > 4