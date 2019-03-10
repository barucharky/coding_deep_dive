with step_1 as
(
select   replace
             (
              replace(field_6,' - ','-'),
              ':',''
             ) no_dash_space
from    `data-science-course-226116.sql_lessons.stock_exchanges_raw_input`
)

select   no_dash_space,
         -- --------------------------------------
         case when lower(no_dash_space) like 'mon%'
             then 'Y'
             else 'N'
         end mon_fri_flag,
         -- --------------------------------------
         trim(replace(lower(no_dash_space),'monday-friday','')) times_open_tz
         -- --------------------------------------
from     step_1