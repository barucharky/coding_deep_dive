select   concat(account, ' - ', campaign) account_campaign,
         sum(cost) / sum(impressions) cost_per_impression,
         max(cost) max_cost
         -- ------------------------------------------------------
from     `data-science-course-226116.sql_lessons.group_by_sandbox`
         -- ------------------------------------------------------
group by account, campaign
         -- ------------------------------------------------------
having   max(cost) > 80
    or   sum(cost) / sum(impressions) > 5
         -- ------------------------------------------------------
order by cost_per_impression desc