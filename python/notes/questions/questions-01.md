# B''H

## Questions for Sruli

---

### Why is this happening?

![](images/questions-01-01.png)

##### Here's the code

```python
def mk_prices():
    prices = []

    while True:
        item = input('Enter item: ')
        price = input('Enter price: ')
        
        prices.append([item, price])
        
        m = input('more?')
        if m == 'n':
            break
    return prices
```

`prices` ceases to exist after I run `hf.mk_prices()`

---

### I don't have any idea what to do with the data sets in jupyter

All I know is head and tail. I think you showed me something else, too.

---

### Should I get the 'Python' extension for VSC?

---

### I'd like to make a Hebrew calendar app

For birthdays and yahrtzeits. It would accept dates and make events where the Hebrew date falls on google calendar.