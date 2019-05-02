--B''H--

-- NCAA team names, mascots, and colors. Why not.

select   mascots.name        team_name,
         mascots.market      team_university,
         mascots.mascot      mascot_desc,
         mascots.mascot_name mascot_name,
         colors.color        team_color
         -- --------------------------------------------------
from     `bigquery-public-data.ncaa_basketball.mascots` mascots
   inner join `bigquery-public-data.ncaa_basketball.team_colors` colors
      on mascots.id = colors.id

-- comparison of level 2 cardiac imaging outpatient charges and quality of treatment in MA hospitals

select   op.provider_name                                          hospital_name,
         op.provider_city                                          hospital_city,
         op.provider_state                                         hospital_state,
         op.average_estimated_submitted_charges                    average_charges,
         op.average_total_payments                                 average_total_payments,
         info.hospital_type                                        hospital_type,
         info.hospital_ownership                                   hospital_ownership,
         info.hospital_overall_rating                              hospital_overall_rating,
         info.mortality_national_comparison                        mortality_national_comparison,
         info.safety_of_care_national_comparison                   safety_of_care_national_comparison,
         info.readmission_national_comparison                      readmission_national_comparison,
         info.patient_experience_national_comparison               patient_experience_national_comparison,
         info.effectiveness_of_care_national_comparison            effectiveness_of_care_national_comparison,
         info.timeliness_of_care_national_comparison               timeliness_of_care_national_comparison,
         info.efficient_use_of_medical_imaging_national_comparison efficient_use_of_medical_imaging_national_comparison
         -- --------------------------------------------------------
from     `bigquery-public-data.cms_medicare.outpatient_charges_2015` op
   inner join `bigquery-public-data.cms_medicare.hospital_general_info` info
      on op.provider_id = info.provider_id
         -- -------------------------------------------------------- 
where    lower(op.apc)            like '0377 - level ii cardiac imaging'
  and    lower(op.provider_state) like 'ma'


-- fertility rates compared to birth/death rates by country. I have no idea why this doesn't work

select   fert.country_name         county,
         fert.year                 year,
         fert.total_fertility_rate total_births_per_woman,
         bd.crude_birth_rate       crude_birth_rate_per_1000,
         bd.crude_death_rate       crude_death_rate_per_1000
         -- -------------------------------------------------
from     `bigquery-public-data.census_bureau_international.age_specific_fertility_rates` fert
   inner join `bigquery-public-data.census_bureau_international.birth_death_growth_rates` bd
      on fert.country_code = bd.country_code
         -- -------------------------------------------------
order by fert.country_name, fert.year desc