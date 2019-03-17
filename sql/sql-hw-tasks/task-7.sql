select   distinct field_6,
         case when lower(field_6) like '%monday - friday%' 
              then 'Y'
              else 'N'
         end step_00_mon_fri_flag
from     `data-science-course-226116.sql_lessons.stock_exchanges_raw_input` 
order by 1