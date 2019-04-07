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
, top_level as
(
select   sum(cost) top_level_cost
from     line_level
)
-- ----------------------------------------------------------         
, account_level as
(
select   account,
         sum(cost) account_cost
from     line_level
group by account         
)
-- ----------------------------------------------------------         
, account_search_keyword_level as
(
select   account,
         search_keyword,
         sum(cost) account_search_keyword_cost
from     line_level
group by account,
         search_keyword         
)
-- ----------------------------------------------------------         
select   ll.*,
         tl.top_level_cost,
         al.account_cost,
         asl.account_search_keyword_cost
from     line_level ll
         -- -------------------------------------------------
   cross join top_level tl        
         -- -------------------------------------------------
   inner join account_level al
      on al.account = ll.account   
         -- -------------------------------------------------
   inner join account_search_keyword_level asl
      on asl.account        = ll.account
     and asl.search_keyword = ll.search_keyword            
         -- -------------------------------------------------
order by ll.account, 
         ll.search_keyword,
         ll.cost desc         