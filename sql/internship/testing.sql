with step_1 as
(
select   field_6,
         replace
             (
              replace(field_6,' - ','-'),
              ':',''
             ) no_dash_space
from    `data-science-course-226116.sql_lessons.stock_exchanges_raw_input`
),

step_2 as
(
select   field_6,
         no_dash_space,
         -- --------------------------------------
         case when lower(no_dash_space) like 'mon%'
             then 'Y'
             else 'N'
         end mon_fri_flag,
         -- --------------------------------------
         trim(replace(lower(no_dash_space),'monday-friday','')) times_open_tz
         -- --------------------------------------
from     step_1
),

step_3 as
(
select   field_6,
         no_dash_space,
         times_open_tz,
         -- --------------------------------------
         case when safe_cast(substr(times_open_tz,1,1) as int64) is null
             then substr(lower(times_open_tz),1,strpos(times_open_tz, ' '))
             else ''
         end time_prefix
from     step_2
),

step_4 as
(
select   field_6,
         no_dash_space,
         time_prefix,
         times_open_tz,
         trim(replace(lower(times_open_tz),time_prefix,'')) times_no_pre
from     step_3
),

step_5 as
(
select   *,
         substr(lower(reverse(times_no_pre)), 1, 1) times_reverse_char_1
from     step_4
),

step_6 as
(
select   *,
         -- --------------------------------------
         case when safe_cast(times_reverse_char_1 as int64) is null
             then substr(times_no_pre,1,strpos(times_no_pre, ' '))
             else times_no_pre
         end times_alone
from     step_5
)

select *,
       -- --------------------------------------
       replace(times_no_pre, times_alone, '') time_suffix
from   step_6