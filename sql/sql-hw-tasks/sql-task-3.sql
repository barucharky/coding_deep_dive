-- B''H --

with step_1 as
(
select  distinct 
        time_zone,
        strpos(time_zone, ' - ') ending_dash_position        
from    `data-science-course-226116.sql_lessons.google_ads_etl_step_1` 
),
-- ----------------------------------------------------------------------
step_2 as
(
select  time_zone,
        -- 
        -- ending_dash_position,
        --
        case 
             when ending_dash_position > 0 then 
                  -- Take everything in the time_zone string until the ending_dash_position:
                  substr(
                      time_zone,            -- parameter 1: string we're going to disect
                      1,                    -- parameter 2: position to start from
                      ending_dash_position  -- parameter 3: how many charachters to go for 
                  ) 
             -- -------------------------------------    
             else time_zone     
        end time_zone_clean
from    step_1
)
-- ----------------------------------------------------------------------
select   time_zone,         
         substr(
             time_zone_clean,          -- parameter 1: string we're going to disect
             13                        -- parameter 2: position to start from
             -- last param not needed  -- parameter 3: how many charachters to go for 
         ) time_zone_clean_new
from     step_2















