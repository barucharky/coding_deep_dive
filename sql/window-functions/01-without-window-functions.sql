-- B''H --



with line_level
as
(
select   account, 
         campaign,
         search_keyword,
         clicks,
         cost
         -- -------------------------------------------------
from     `data-science-course-226116.sql_lessons.google_ads_etl_step_1` 
         -- -------------------------------------------------
where    cost > 45
)
-- ----------------------------------------------------------         
, aggregate_level as
(
select   account,
         sum(cost) account_cost
from     line_level
group by account         
)
-- ----------------------------------------------------------         
select   ll.*,
         al.account_cost
from     line_level ll
         -- -------------------------------------------------
   inner join aggregate_level al
      on al.account = ll.account     
         -- -------------------------------------------------
order by ll.account, ll.cost desc         