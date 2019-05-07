--B''H--


select   *,
         -- --------------------------------------------------------------------
         to_hex(
            sha512(
               concat(
                  coalesce(account,                        '<account_field>'),
                  coalesce(campaign,                       '<campaign_field>'),
                  coalesce(search_keyword,                 '<search_keyword_field>'),
                  coalesce(headline,                       '<headline_field>'),
                  coalesce(headline_1,                     '<headline_1_field>'),
                  coalesce(headline_2,                     '<headline_2_field>'),
                  coalesce(expanded_text_ad_headline_3,    '<expanded_text_ad_headline_3_field>'),
                  coalesce(short_headline,                 '<short_headline_field>'),
                  coalesce(long_headline,                  '<long_headline_field>'),
                  coalesce(description,                    '<description_field>'),
                  coalesce(expanded_text_ad_description_2, '<expanded_text_ad_description_2_field>'),
                  coalesce(description_line_1,             '<description_line_1_field>'),
                  coalesce(description_line_2,             '<description_line_2_field>'),
                  coalesce(display_url,                    '<display_url_field>'),
                  coalesce(ad,                             '<ad_field>'),
                  coalesce(path_1,                         '<path_1_field>'),
                  coalesce(path_2,                         '<path_2_field>'),
                  coalesce(business_name,                  '<business_name_field>'),
                  coalesce(ad_group,                       '<ad_group_field>'),
                  coalesce(search_term,                    '<search_term_field>'),
                  coalesce(device,                         '<device_field>'),
                  coalesce(network_with_search_partners,   '<network_with_search_partners_field>'),
                  coalesce(time_zone,                      '<time_zone_field>'),
                  coalesce(currency,                       '<currency_field>'),
                  coalesce(labels_on_account,              '<labels_on_account_field>'),
                  coalesce(ad_state,                       '<ad_state_field>'),
                  coalesce(ad_status,                      '<ad_status_field>'),
                  coalesce(ad_final_url,                   '<ad_final_url_field>'),
                  coalesce(quality_score,                  '<quality_score_field>'),
                  coalesce(month,                          '<month_field>'),
                  coalesce(day,                            '<day_field>'),
                  coalesce(day_of_week,                    '<day_of_week_field>'),
                  coalesce(year,                           '<year_field>'),
                  coalesce(ad_relevance,                   '<ad_relevance_field>'),
                  coalesce(landing_page_experience,        '<landing_page_experience_field>'),
                  coalesce(expected_clickthrough_rate,     '<expected_clickthrough_rate_field>'),
                  coalesce(search_term_match_type,         '<search_term_match_type_field>'),
                  coalesce(search_keyword_status,          '<search_keyword_status_field>'),
                  coalesce(clicks,                         '<clicks_field>'),
                  coalesce(impressions,                    '<impressions_field>'),
                  coalesce(cost,                           '<cost_field>'),
                  coalesce(ctr,                            '<ctr_field>'),
                  coalesce(avg_cpc,                        '<avg_cpc_field>'),
                  coalesce(avg_position,                   '<avg_position_field>'),
                  coalesce(conversions,                    '<conversions_field>'),
                  coalesce(cost_divided_by_conv,           '<cost_divided_by_conv_field>'),
                  coalesce(conv_rate,                      '<conv_rate_field>'),
                  coalesce(view_through_conv,              '<view_through_conv_field>'),
                  coalesce(all_conv,                       '<all_conv_field>'),
                  coalesce(cross_device_conv,              '<cross_device_conv_field>'),
                  coalesce(all_conv_rate,                  '<all_conv_rate_field>')
               )
            )
         ) hex_from_sha512
         -- --------------------------------------------------------------------
from     `data-science-course-226116.sql_lessons.google_ads`