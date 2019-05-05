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

-- All possible combinations of toppings for ice cream

with
-- Here are all available toppings

toppings as
(
select   'fudge'         topping union all
select   'caramel'       topping union all
select   'nuts'          topping union all
select   'sprinkles'     topping union all
select   'whip'          topping union all
select   null            topping
),


/*
_______________________________________________________________________
here are all possible combinations
each id represents a customer with his set of toppings accross 5 fields
('fudge', 'fudge') is the same as ('fudge', null)
_______________________________________________________________________
*/
combos as
(
select   row_number() over () id,
         s1.topping           s1_topping,
         s2.topping           s2_topping,
         s3.topping           s3_topping,
         s4.topping           s4_topping,
         s5.topping           s5_topping
         -- -----------------------------
from     toppings s1
   cross join toppings s2
   cross join toppings s3
   cross join toppings s4
   cross join toppings s5
),


/* 
since each customer must have 5 toppings at this point (including nulls and duplicates)
and they must be listed vertically (pivoted) each topping in a set (id) will have a number
*/
sets as
(
select   1 topping_num union all
select   2             union all
select   3             union all
select   4             union all
select   5        
),


/*
each combination listed by topping number and id
*/
combos_unpivoted as
(
select   id,
         topping_num,
         case topping_num
              when 1 then s1_topping
              when 2 then s2_topping
              when 3 then s3_topping
              when 4 then s4_topping
              when 5 then s5_topping
         end topping_value
         -- ------------------------              
from     combos
   cross join sets
),


/*
here they are grouped by id and aggragated by distinct topping_value which is ordered.
this means that now, both ('fudge', 'fudge') and ('fudge', null) and (null, 'fudge')
will all become 'fudge'

distinct changes ('fudge', 'fudge') to 'fudge'
order by makes ('fudge', null) and (null, 'fudge') the same
the null is lost in aggragation
*/
combos_csv as
(
select   id,
         -- -----------------------------
         string_agg(
             distinct topping_value, ', '
             order by topping_value
         ) topping_values
         -- -----------------------------
from     combos_unpivoted
group by id
)


/*
because ('fudge', 'fudge') and ('fudge', null) and (null, 'fudge') all aggragate
to 'fudge', there are now duplicates. this is resolved by distinct
*/
select   distinct topping_values
from     combos_csv
order by 1
