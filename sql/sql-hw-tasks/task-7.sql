-- B''H --

with step_00 as
(
select   distinct field_6,
         -- -----------------------
         case 
             when lower(field_6) like '%monday - friday%' 
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
         case 
             when step_02_str_pos_of_colon > 0
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
         case 
             when safe_cast(
              substr(
                   step_03_str_up_to_first_colon, 
                   1, 
                   1) as int64
                   ) is null
             then step_03_str_up_to_first_colon
             else ''
         end step_05_times_prefix
from     step_04
),

step_06 as
(
select   *,
         replace(step_01_remove_mon_fri, 
                 concat(step_05_times_prefix, ': '),
                 ''
                 ) step_06_remove_times_prefix
from     step_05
),

step_07 as
(
select   *,
         replace(step_06_remove_times_prefix, 
               ' - ', 
               '-'
               ) step_07_replace_blank_dash_blank
from     step_06
),

step_08 as
(
select *,
       strpos(step_07_replace_blank_dash_blank, 
              ':00 '
             ) step_08_str_pos_of_colon_zero_zero_blank
from step_07
),

step_09 as
(
select   *,
         case 
              when step_08_str_pos_of_colon_zero_zero_blank > 0
              then substr(
                   step_07_replace_blank_dash_blank, 
                   step_08_str_pos_of_colon_zero_zero_blank + 4)
              else ''
          end step_09_times_suffix
from     step_08
),

step_10 as
(
select   *,
         replace(step_07_replace_blank_dash_blank, 
                 step_09_times_suffix, 
                 ''
                 ) step_10_remove_times_suffix
from     step_09
),

step_11 as
(
select   *,
         trim
         (
              replace
              (
                   step_10_remove_times_suffix, 
                   ':', 
                   ''
                 )
             ) step_11_remove_colons
from     step_10
),

step_12 as
(
select   *,
         strpos(
                step_11_remove_colons, 
                '/'
               ) step_12_str_pos_of_slash
from     step_11
),

step_13 as
(
select   *,
         case 
              when step_12_str_pos_of_slash > 0
              then substr(step_11_remove_colons, 
                   1, 
                   step_12_str_pos_of_slash - 1)
              else step_11_remove_colons
          end step_13_times_part_1
from     step_12
),

step_14 as
(
select   *,
         case 
              when step_12_str_pos_of_slash > 0
              then substr(step_11_remove_colons,
                   step_12_str_pos_of_slash + 1)
          end step_14_times_part_2
from     step_13
),

step_15 as
(
select   *,
         substr(
              step_13_times_part_1, 
              1, strpos(
                   step_13_times_part_1, 
                   '-'
                 ) - 1
          ) step_15_times_part_1_open
from     step_14
),

step_16 as
(
select   *,
         substr(
              step_13_times_part_1,
              strpos(
                   step_13_times_part_1,
                   '-'
              ) + 1
         ) step_16_times_part_1_close
from     step_15
),

step_17 as
(
select   *,
         case 
              when step_14_times_part_2 is not null
              then substr(
                   step_14_times_part_2,
                   1,
                   strpos(
                        step_14_times_part_2, 
                        '-'
                   ) - 1
              )
          end step_17_times_part_2_open
from     step_16
),

step_18 as
(
select   *,
         case 
              when step_14_times_part_2 is not null
              then substr(
                   step_14_times_part_2,
                   strpos(
                        step_14_times_part_2,
                        '-'
                   ) + 1
              )
          end step_18_times_part_2_close
from     step_17
),

step_19 as
(
select   *,
         concat(
              step_15_times_part_1_open,
              ':00'
         ) step_19_times_part_1_open_add_00
from     step_18
),

step_20 as
(
select   *,
         concat(
              step_16_times_part_1_close,
              ':00'
         ) step_20_times_part_1_close_add_00
from     step_19
),

step_21 as
(
select   *,
         case
              when step_17_times_part_2_open is not null
              then concat(
                   step_17_times_part_2_open,
                   ':00'
              )
          end step_21_times_part_2_open_add_00
from     step_20
),

step_22 as
(
select   *,
         case 
           when step_18_times_part_2_close is not null
           then concat(
                step_18_times_part_2_close,
                ':00'
           ) 
         end step_22_times_part_2_close_add_00
from     step_21
),

step_23 as
(
select   *,
         strpos(
              step_19_times_part_1_open_add_00,
              ':'
         ) step_23_times_part_1_open_str_pos_colon
from     step_22
),

step_24 as
(
select   *,
         strpos(
              step_20_times_part_1_close_add_00,
              ':'
         ) step_24_times_part_1_close_str_pos_colon
from     step_23
),

step_25 as
(
select   *,
         case
              when step_21_times_part_2_open_add_00 is not null
              then strpos(
                   step_21_times_part_2_open_add_00,
                   ':'
              ) 
          end step_25_times_part_2_open_str_pos_colon
from     step_24
),

step_26 as
(
select   *,
         case
              when step_22_times_part_2_close_add_00 is not null
              then strpos(
                   step_22_times_part_2_close_add_00,
                   ':'
              )
          end step_26_times_part_2_close_str_pos_colon
from     step_25
)

select   *

from     step_26