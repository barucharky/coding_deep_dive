with step_00 as
(
select   distinct field_6,
         -- -----------------------
         case when lower(field_6) like '%monday - friday%' 
              then 'Y'
              else 'N'
         end step_00_mon_fri_flag
         -- -----------------------
from     `data-science-course-226116.sql_lessons.stock_exchanges_raw_input` 
order by 1
),

step_01 as
(
select   *,
         trim(replace(field_6, 'Monday - Friday:', '')) step_01_remove_mon_fri
from     step_00
)

select   *,
         strpos(step_01_remove_mon_fri,':') step_02_str_pos_of_colon
from     step_01