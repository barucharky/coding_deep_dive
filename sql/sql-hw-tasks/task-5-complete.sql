select    distinct fips_class_code,
          -- ----------------------------
          substr(fips_class_code, 1, 1) as char_1,
          substr(fips_class_code, 2, 1) as char_2,
          -- ----------------------------
          case cast(substr(fips_class_code, 2, 1) as int64)
             when 1 then 'One'
             when 2 then 'Two'
             when 3 then 'Three'
             when 4 then 'Four'
             when 5 then 'Five'
             when 6 then 'Six'
             when 7 then 'Seven'
          end char2_desc
          -- ----------------------------
from `data-science-course-226116.sql_lessons.counties`
          -- ----------------------------
order by char_2
