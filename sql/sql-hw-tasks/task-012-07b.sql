-- B''H --

with stg_00 as
(
select   distinct field_6
from     `data-science-course-226116.sql_lessons.stock_exchanges_raw_input` 
order by 1
),

stg_01 as
(
select   *,
         case when field_6 like 'Monday - Friday:%'
              then 'Y'
              else 'N'
         end step_00_mon_fri_flag
from     stg_00
),

stg_02 as
(
select   *,
         case when step_00_mon_fri_flag like 'Y'
              then trim(substr(field_6, 17))
              else field_6
         end step_01_remove_mon_fri
from     stg_01
),

stg_03 as
(
select   *,
         strpos(step_01_remove_mon_fri, ':') step_02_str_pos_of_colon
from     stg_02
),

stg_04 as
(
select   *,
         case when step_02_str_pos_of_colon > 0
              then substr(step_01_remove_mon_fri, 1, step_02_str_pos_of_colon - 1)
              else null
         end step_03_str_up_to_first_colon
         from stg_03
),

stg_05 as
(
select   *,
         safe_cast(step_03_str_up_to_first_colon as int64) step_04_str_up_to_first_colon_as_int64
from     stg_04
),

stg_06 as
(
select   *,
         case when safe_cast(step_03_str_up_to_first_colon as int64) is null
              then step_03_str_up_to_first_colon
              else null
         end step_05_times_prefix
from     stg_05
),

stg_07 as
(
select   *,
         case when step_05_times_prefix is not null
              then substr(step_01_remove_mon_fri, step_02_str_pos_of_colon + 1)
              else step_01_remove_mon_fri
         end step_06_remove_times_prefix
from     stg_06
),

stg_08 as
(
select   *,
         trim(replace(step_06_remove_times_prefix, ' - ', '-')) step_07_replace_blank_dash_blank
from     stg_07
),

stg_09 as
(
select   *,
         strpos(step_07_replace_blank_dash_blank, ':00 ') step_08_str_pos_of_colon_zero_zero_blank
from     stg_08
),

stg_10 as
(
select   *,
         case when step_08_str_pos_of_colon_zero_zero_blank > 0
              then trim(substr(step_07_replace_blank_dash_blank, step_08_str_pos_of_colon_zero_zero_blank + 4))
              else null
         end step_09_times_suffix
from     stg_09
),

stg_11 as
(
select   *,
         case when step_09_times_suffix is not null
              then trim(replace(step_07_replace_blank_dash_blank, step_09_times_suffix, ''))
              else step_07_replace_blank_dash_blank
         end step_10_remove_times_suffix
from     stg_10
),

stg_12 as
(
select   *,
         trim(replace(step_10_remove_times_suffix, ':', '')) step_11_remove_colons
from     stg_11
),

stg_13 as
(
select   *,
         strpos(step_11_remove_colons, '/') step_12_str_pos_of_slash
from     stg_12
),

stg_14 as
(
select   *,
         case when step_12_str_pos_of_slash > 0
              then substr(step_11_remove_colons, 1, step_12_str_pos_of_slash - 1)
              else step_11_remove_colons
         end step_13_times_part_1,
         case when step_12_str_pos_of_slash > 0
              then substr(step_11_remove_colons, step_12_str_pos_of_slash + 1)
              else null
         end step_14_times_part_2
from     stg_13
)

select   *
from     stg_