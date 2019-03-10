select   field_2 name,
         field_3 symbol,
         field_4 continent,
         field_5 country
         -- ---------------------------
from `data-science-course-226116.sql_lessons.stock_exchanges_raw_input`
         -- ---------------------------
where field_4 in ('Americas', 'Europe', 'Asia')
