--B''H--

with
midos as
(
select   '1Chesed'  midah union all
select   '2Gevurah' midah union all
select   '3Tiferes' midah union all
select   '4Netzach' midah union all
select   '5Hod'     midah union all
select   '6Yesod'   midah union all
select   '7Malchus' midah
),

he_midos as
(
select   '1חסד'    midah union all
select   '2גבורה'   midah union all
select   '3תפרת'   midah union all
select   '4נצח'    midah union all
select   '5הוד'    midah union all
select   '6יסוד'    midah union all
select   '7מלכות'  midah
),

he_sefiros as
(
select   dense_rank() over(order by m2.midah, m1.midah) day,
         substr(m1.midah, 2) he_day_midah,
         substr(m2.midah, 2) he_week_midah
         -- ----------------------------
from     he_midos m1, he_midos m2
order by m2.midah, m1.midah
),

sefiros as
(
select   dense_rank() over(order by m2.midah, m1.midah) day,
         substr(m1.midah, 2) day_midah,
         substr(m2.midah, 2) week_midah
         -- ----------------------------
from     midos m1, midos m2
order by m2.midah, m1.midah
)

select   en.day,
         concat(day_midah, ' shebeh ', week_midah) sefirah,
         concat(he_day_midah, ' שב', he_week_midah) hebrew_sefirah
from     sefiros en
    full join he_sefiros he
      on en.day = he.day