--B''H--

-- Deck of cards
with
face as
(
select   'Ace'   card_value union all
select   '2'     card_value union all
select   '3'     card_value union all
select   '4'     card_value union all
select   '5'     card_value union all
select   '6'     card_value union all
select   '7'     card_value union all
select   '8'     card_value union all
select   '9'     card_value union all
select   '10'    card_value union all
select   'Jack'  card_value union all
select   'Queen' card_value union all
select   'King'  card_value 
),

suit as
(
select '♡' us union all
select '♢' us union all
select '♣' us union all
select '♠' us 
)

select   face.card_value card_value,
         suit.us         suit
         -- ------------------------
from     face
   cross join suit

-- kids and candy and snacks. everybody gets. check off when they get, nobody gets doubles

with
kids as
(
select   'Mendy'   name union all
select   'Shmuely' name union all
select   'Lippy'   name union all
select   'Ari'     name
),

snacks as
(
select   'lollipop' junk union all
select   'chips'    junk union all
select   'wafers'   junk union all
select   'taffy'    junk
)

select   kids.name   name,
         snacks.junk junk_food
         -- ------------------
from     kids
   cross join snacks

-- I can't figure out a way to get rid of duplicates. Maybe this isn't a case for a cross join

with
stuff as
(
select   'lettuce' topping union all
select   'tomato' topping union all
select   'cheese' topping union all
select   'onion' topping union all
select   'mustard' topping union all
select   null topping
),

combos as
(
select   distinct
         s1.topping s1_topping,
         s2.topping s2_topping,
         s3.topping s3_topping,
         s4.topping s4_topping,
         s5.topping s5_topping
from     stuff s1
   cross join stuff s2
   cross join stuff s3
   cross join stuff s4
   cross join stuff s5
)

select   *
from     combos
where    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%lettuce%lettuce%' 
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%tomato%tomato%' 
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%cheese%cheese%' 
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%onion%onion%' 
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%mustard%mustard%'
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%<NO_TOP>%l%'
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%<NO_TOP>%t%'
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%<NO_TOP>%c%'
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%<NO_TOP>%o%'
  and    concat(coalesce(s1_topping, '<NO_TOP>'), coalesce(s2_topping, '<NO_TOP>'), coalesce(s3_topping, '<NO_TOP>'), coalesce(s4_topping, '<NO_TOP>'), coalesce(s5_topping, '<NO_TOP>')) not like '%<NO_TOP>%m%'
  and    s1_topping <> '<NO_TOP>'
order by 1, 2, 3, 4, 5