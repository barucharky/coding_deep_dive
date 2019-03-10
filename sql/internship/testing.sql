with step_1 as
(
select   replace
            (
             replace(field_6,' - ','-'),
             ':',''
             ) no_dash_space
FROM `data-science-course-226116.sql_lessons.stock_exchanges_raw_input`
)

select   no_dash_space
from step_1
