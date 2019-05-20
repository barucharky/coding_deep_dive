--B''H--

with
midos as
(
select   1 id, 'Chesed'  midah union all
select   2 id, 'Gevurah' midah union all
select   3 id, 'Tiferes' midah union all
select   4 id, 'Netzach' midah union all
select   5 id, 'Hod'     midah union all
select   6 id, 'Yesod'   midah union all
select   7 id, 'Malchus' midah
),

he_midos as
(
select   1 id, 'חסד'    midah union all
select   2 id, 'גבורה'   midah union all
select   3 id, 'תפרת'   midah union all
select   4 id, 'נצח'    midah union all
select   5 id, 'הוד'    midah union all
select   6 id, 'יסוד'    midah union all
select   7 id, 'מלכות'  midah
),

he_sefiros as
(
select   dense_rank() over(order by m2.id, m1.id) day,
         -- ----------------------------
         m1.midah he_day_midah,
         m2.midah he_week_midah
         -- ----------------------------
from     he_midos m1, he_midos m2
order by m2.id, m1.id desc
),

sefiros as
(
select   dense_rank() over(order by m2.id, m1.id) day,
         -- ----------------------------
         m1.midah day_midah,
         m2.midah week_midah
         -- ----------------------------
from     midos m1, midos m2
order by m2.id, m1.id desc
)

select   en.day,
         concat(day_midah, ' sheb\'', week_midah) sefirah,
         concat(he_day_midah, ' שב', he_week_midah) hebrew_sefirah
from     sefiros en
   inner join he_sefiros he
      on en.day = he.day