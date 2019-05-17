# B''H

---

Here are notes on the first glance at the notebook `../01-plots/joint-and-pair-plots.ipynb`

---

### Libraries used

The first thing it does is import libraries. The ones that are necessary for plotting data are:
- `pandas` 
   - used to read csv files and produce dataframes that python can handle
- `seaborn` 
   - renders graphs and charts
- `matplotlib.pyplot` 
   - similar to `seaborn`, unclear in the scope of this notebook what it adds

---

### Joint plots

**Continuous random variables** are introduced. The are variables that can vary on an infinite scale, like time or size, but not quantity.

The different *kinds* are introduced. The default is 'scatter', 'reg' adds a regression line, 'kde' and 'hex' are two ways to display joint distribution.

---

### Pair plots

This is useful when you want to compare more than two variable. It will produce multiple charts according to specifications to compare each variable to each variable. You can add multiple regression lines to represent different variables that are not continuous.