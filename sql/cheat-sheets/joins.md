# B''H

#Joins
---

### INNER JOIN          80%

   #### Only return the records that have a match
   ```sql

   select   emp.*,
            dept.name
   from     `data-science-course-226116.sql_lessons.employees` emp
            -- ---------------------------------------
      inner join `data-science-course-226116.sql_lessons.departments` dept
         on dept.id = emp.dept_id
            -- ---------------------------------------
   ```

---

### LEFT OUTER JOIN     16%
   
   ```sql
   -- Level-of-Grain: emp.id
   -- Because an employee can max belong to one department
   select   emp.*,  
            dept.name
   from     `data-science-course-226116.sql_lessons.employees` emp
            -- ---------------------------------------
       left outer join `data-science-course-226116.sql_lessons.departments` dept
         on dept.id = emp.dept_id
            -- ---------------------------------------
   order by emp.id      
   ```

---

### CROSS JOIN          3.9%
   ```sql
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
   ```

---

### FULL JOIN           .1 %


---

### RIGHT OUTER JOIN    NEVER