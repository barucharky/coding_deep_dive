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
         --
         case when step_12_str_pos_of_slash > 0
              then substr(step_11_remove_colons, step_12_str_pos_of_slash + 1)
              else null
         end step_14_times_part_2
         --
from     stg_13
),

stg_15 as
(
select   *,
         substr(step_13_times_part_1, 1, strpos(step_13_times_part_1, '-') - 1) step_15_times_part_1_open,
         substr(step_13_times_part_1, strpos(step_13_times_part_1, '-') + 1) step_16_times_part_1_close,
         --
         case when step_14_times_part_2 is not null
              then substr(step_14_times_part_2, 1, strpos(step_14_times_part_2, '-') - 1)
              else null
         end step_17_times_part_2_open,
         --
         case when step_14_times_part_2 is not null
              then substr(step_14_times_part_2, strpos(step_14_times_part_2, '-') + 1)
              else null
         end step_18_times_part_2_close
from     stg_14
),

stg_16 as
(
select   *,
         concat(step_15_times_part_1_open, ':00') step_19_times_part_1_open_add_00,
         concat(step_16_times_part_1_close, ':00') step_20_times_part_1_close_add_00,
         --
         case when step_17_times_part_2_open is not null
              then concat(step_17_times_part_2_open, ':00')
              else null
         end step_21_times_part_2_open_add_00,
         --
         case when step_18_times_part_2_close is not null
              then concat(step_18_times_part_2_close, ':00')
              else null
         end step_22_times_part_2_close_add_00
from     stg_15
),

stg_17 as
(
select   *,
         strpos(step_19_times_part_1_open_add_00, ':') step_23_times_part_1_open_str_pos_colon,
         strpos(step_20_times_part_1_close_add_00, ':') step_24_times_part_1_close_str_pos_colon,
         --
         case when step_21_times_part_2_open_add_00 is not null
              then strpos(step_21_times_part_2_open_add_00, ':')
              else null
         end step_25_times_part_2_open_str_pos_colon,
         --
         case when step_22_times_part_2_close_add_00 is not null
              then strpos(step_22_times_part_2_close_add_00, ':')
              else null
         end step_26_times_part_2_close_str_pos_colon
from     stg_16
),

stg_18 as
(
select   *,
         concat(substr(step_19_times_part_1_open_add_00, 1, step_23_times_part_1_open_str_pos_colon - 3), ':', substr(step_19_times_part_1_open_add_00, step_23_times_part_1_open_str_pos_colon - 2)) step_27_times_part_1_open_with_new_colon,
         concat(substr(step_20_times_part_1_close_add_00, 1, step_24_times_part_1_close_str_pos_colon - 3), ':', substr(step_20_times_part_1_close_add_00, step_24_times_part_1_close_str_pos_colon - 2)) step_28_times_part_1_close_with_new_colon,
         --
         case when step_21_times_part_2_open_add_00 is not null
              then concat(substr(step_21_times_part_2_open_add_00, 1, step_25_times_part_2_open_str_pos_colon - 3), ':', substr(step_21_times_part_2_open_add_00, step_25_times_part_2_open_str_pos_colon - 2))
              else null
         end step_29_times_part_2_open_with_new_colon,
         --
         case when step_22_times_part_2_close_add_00 is not null
              then concat(substr(step_22_times_part_2_close_add_00, 1, step_26_times_part_2_close_str_pos_colon - 3), ':', substr(step_22_times_part_2_close_add_00, step_26_times_part_2_close_str_pos_colon - 2))
              else null
         end step_30_times_part_2_close_with_new_colon
from     stg_17
),

stg_19 as
(
select   *,
         safe_cast(step_27_times_part_1_open_with_new_colon as time) step_31_times_part_1_open_cast_as_time,
         safe_cast(step_28_times_part_1_close_with_new_colon as time) step_32_times_part_1_close_cast_as_time,
         safe_cast(step_29_times_part_2_open_with_new_colon as time) step_33_times_part_2_open_cast_as_time,
         safe_cast(step_30_times_part_2_close_with_new_colon as time) step_34_times_part_2_close_cast_as_time
from     stg_18
)

select   *
from     stg_19