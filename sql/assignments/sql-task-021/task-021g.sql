--B''H--

-- -----------------------------------------
-- Deck of cards
-- -----------------------------------------

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



-- -----------------------------------------
-- kids and candy and snacks. everybody gets. check off when they get, nobody gets doubles
-- -----------------------------------------

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


