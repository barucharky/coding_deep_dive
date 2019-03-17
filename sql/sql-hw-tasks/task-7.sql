-- B''H --

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
         trim(
              replace(
                   field_6, 
                   'Monday - Friday:', 
                   ''
                   )
             ) step_01_remove_mon_fri
from     step_00
),

step_02 as
(
select   *,
         strpos(
              step_01_remove_mon_fri, 
              ':'
              ) step_02_str_pos_of_colon
from     step_01
),
step_03 as
(
select   *,
         case when step_02_str_pos_of_colon > 0
             then substr(
                  step_01_remove_mon_fri, 
                  1, 
                  step_02_str_pos_of_colon - 1 
                  ) 
             else ''
         end step_03_str_up_to_first_colon
from     step_02
),

step_04 as
(
select   *,
         safe_cast(step_03_str_up_to_first_colon as int64) step_04_str_up_to_first_colon_as_int64	
from     step_03
),

step_05 as
(
select   *,
         case when safe_cast(
              substr(
                   step_03_str_up_to_first_colon, 
                   1, 
                   1) as int64
                   ) is null
             then step_03_str_up_to_first_colon
             else ''
         end step_05_times_prefix
from     step_04
)

select   *,
         replace(step_01_remove_mon_fri, 
                 concat(step_05_times_prefix, ': '),
                 ''
                 )
from     step_05