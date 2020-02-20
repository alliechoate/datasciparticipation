---
title: "s06 Exercises: Pivoting and tidy data"
author: "Allie Choate"
output: 
  html_document:
    keep_md: true
    theme: paper
---


```r
library(tidyverse)
lotr  <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
guest <- read_csv("https://raw.githubusercontent.com/USF-Psych-DataSci/Classroom/master/data/wedding/attend.csv")
email <- read_csv("https://raw.githubusercontent.com/USF-Psych-DataSci/Classroom/master/data/wedding/emails.csv")
```

<!---The following chunk allows errors when knitting--->




## Exercise 1: Univariate Pivoting

Consider the Lord of the Rings data:


```r
lotr
```

```
## # A tibble: 18 x 4
##    Film                       Race   Gender Words
##    <chr>                      <chr>  <chr>  <dbl>
##  1 The Fellowship Of The Ring Elf    Female  1229
##  2 The Fellowship Of The Ring Hobbit Female    14
##  3 The Fellowship Of The Ring Man    Female     0
##  4 The Two Towers             Elf    Female   331
##  5 The Two Towers             Hobbit Female     0
##  6 The Two Towers             Man    Female   401
##  7 The Return Of The King     Elf    Female   183
##  8 The Return Of The King     Hobbit Female     2
##  9 The Return Of The King     Man    Female   268
## 10 The Fellowship Of The Ring Elf    Male     971
## 11 The Fellowship Of The Ring Hobbit Male    3644
## 12 The Fellowship Of The Ring Man    Male    1995
## 13 The Two Towers             Elf    Male     513
## 14 The Two Towers             Hobbit Male    2463
## 15 The Two Towers             Man    Male    3589
## 16 The Return Of The King     Elf    Male     510
## 17 The Return Of The King     Hobbit Male    2673
## 18 The Return Of The King     Man    Male    2459
```

1. Would you say this data is in tidy format?

   <!-- Describe why or why not in this space. -->

2. Widen the data so that we see the words spoken by each race, by putting race as its own column.


```r
(lotr_wide <- lotr %>% 
  pivot_wider(id_cols = c(-Race, -Words), #columns you would like to keep
              names_from = Race, #the new column names are coming from an old column.
              values_from = Words)) #the values under the new columns are coming from an old column.
```

```
## # A tibble: 6 x 5
##   Film                       Gender   Elf Hobbit   Man
##   <chr>                      <chr>  <dbl>  <dbl> <dbl>
## 1 The Fellowship Of The Ring Female  1229     14     0
## 2 The Two Towers             Female   331      0   401
## 3 The Return Of The King     Female   183      2   268
## 4 The Fellowship Of The Ring Male     971   3644  1995
## 5 The Two Towers             Male     513   2463  3589
## 6 The Return Of The King     Male     510   2673  2459
```

3. Re-lengthen the wide LOTR data from Question 2 above.


```r
lotr_wide %>% 
  pivot_longer(cols = c("Hobbit","Man","Elf"),
               names_to  = "Race",
               values_to="Words")
```

```
## # A tibble: 18 x 4
##    Film                       Gender Race   Words
##    <chr>                      <chr>  <chr>  <dbl>
##  1 The Fellowship Of The Ring Female Hobbit    14
##  2 The Fellowship Of The Ring Female Man        0
##  3 The Fellowship Of The Ring Female Elf     1229
##  4 The Two Towers             Female Hobbit     0
##  5 The Two Towers             Female Man      401
##  6 The Two Towers             Female Elf      331
##  7 The Return Of The King     Female Hobbit     2
##  8 The Return Of The King     Female Man      268
##  9 The Return Of The King     Female Elf      183
## 10 The Fellowship Of The Ring Male   Hobbit  3644
## 11 The Fellowship Of The Ring Male   Man     1995
## 12 The Fellowship Of The Ring Male   Elf      971
## 13 The Two Towers             Male   Hobbit  2463
## 14 The Two Towers             Male   Man     3589
## 15 The Two Towers             Male   Elf      513
## 16 The Return Of The King     Male   Hobbit  2673
## 17 The Return Of The King     Male   Man     2459
## 18 The Return Of The King     Male   Elf      510
```


## Exercise 2: Multivariate Pivoting

Congratulations, you're getting married! In addition to the wedding, you've 
decided to hold two other events: a day-of brunch and a day-before round of 
golf. You've made a guestlist of attendance so far, along with food preference 
for the food events (wedding and brunch).


```r
guest %>% 
  DT::datatable(rownames = FALSE)
```

<!--html_preserve--><div id="htmlwidget-6eb2b6645edc972828c8" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-6eb2b6645edc972828c8">{"x":{"filter":"none","data":[[1,1,1,1,2,2,3,4,5,5,5,6,6,7,7,8,9,10,11,12,12,12,12,12,13,13,14,14,15,15],["Sommer Medrano","Phillip Medrano","Blanka Medrano","Emaan Medrano","Blair Park","Nigel Webb","Sinead English","Ayra Marks","Atlanta Connolly","Denzel Connolly","Chanelle Shah","Jolene Welsh","Hayley Booker","Amayah Sanford","Erika Foley","Ciaron Acosta","Diana Stuart","Cosmo Dunkley","Cai Mcdaniel","Daisy-May Caldwell","Martin Caldwell","Violet Caldwell","Nazifa Caldwell","Eric Caldwell","Rosanna Bird","Kurtis Frost","Huma Stokes","Samuel Rutledge","Eddison Collier","Stewart Nicholls"],["PENDING","vegetarian","chicken","PENDING","chicken",null,"PENDING","vegetarian","PENDING","fish","chicken",null,"vegetarian",null,"PENDING","PENDING","vegetarian","PENDING","fish","chicken","PENDING","PENDING","chicken","chicken","vegetarian","PENDING",null,"chicken","PENDING","chicken"],["PENDING","Menu C","Menu A","PENDING","Menu C",null,"PENDING","Menu B","PENDING","Menu B","Menu C",null,"Menu C","PENDING","PENDING","Menu A","Menu C","PENDING","Menu C","Menu B","PENDING","PENDING","PENDING","Menu B","Menu C","PENDING",null,"Menu C","PENDING","Menu B"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","CANCELLED","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>party<\/th>\n      <th>name<\/th>\n      <th>meal_wedding<\/th>\n      <th>meal_brunch<\/th>\n      <th>attendance_wedding<\/th>\n      <th>attendance_brunch<\/th>\n      <th>attendance_golf<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

1. Put "meal" and "attendance" as their own columns, with the events living in a new column.


```r
(guest_long <- guest %>% 
  pivot_longer(cols= c(starts_with("attendance"), starts_with("meal")),
               names_to  = c(".value","event"), #.value v importante here amigo!!!!
               values_to = "confirmation",
              names_sep="_")) 
```

```
## # A tibble: 90 x 5
##    party name            event   attendance meal      
##    <dbl> <chr>           <chr>   <chr>      <chr>     
##  1     1 Sommer Medrano  wedding PENDING    PENDING   
##  2     1 Sommer Medrano  brunch  PENDING    PENDING   
##  3     1 Sommer Medrano  golf    PENDING    <NA>      
##  4     1 Phillip Medrano wedding CONFIRMED  vegetarian
##  5     1 Phillip Medrano brunch  CONFIRMED  Menu C    
##  6     1 Phillip Medrano golf    CONFIRMED  <NA>      
##  7     1 Blanka Medrano  wedding CONFIRMED  chicken   
##  8     1 Blanka Medrano  brunch  CONFIRMED  Menu A    
##  9     1 Blanka Medrano  golf    CONFIRMED  <NA>      
## 10     1 Emaan Medrano   wedding PENDING    PENDING   
## # … with 80 more rows
```


2. Use `tidyr::separate()` to split the name into two columns: "first" and 
"last." Then, re-unite them with `tidyr::unite()`.


```r
guest_long %>% 
  separate(name, into = c("first", "last")) %>%
  unite("name", first:last, sep=" ") 
```

```
## # A tibble: 90 x 5
##    party name            event   attendance meal      
##    <dbl> <chr>           <chr>   <chr>      <chr>     
##  1     1 Sommer Medrano  wedding PENDING    PENDING   
##  2     1 Sommer Medrano  brunch  PENDING    PENDING   
##  3     1 Sommer Medrano  golf    PENDING    <NA>      
##  4     1 Phillip Medrano wedding CONFIRMED  vegetarian
##  5     1 Phillip Medrano brunch  CONFIRMED  Menu C    
##  6     1 Phillip Medrano golf    CONFIRMED  <NA>      
##  7     1 Blanka Medrano  wedding CONFIRMED  chicken   
##  8     1 Blanka Medrano  brunch  CONFIRMED  Menu A    
##  9     1 Blanka Medrano  golf    CONFIRMED  <NA>      
## 10     1 Emaan Medrano   wedding PENDING    PENDING   
## # … with 80 more rows
```



3. Which parties still have a "PENDING" status for all members and all events?


```r
guest_long %>% 
  group_by(party) %>% 
  summarize(all_pending = all(attendance == "PENDING"))
```

```
## # A tibble: 15 x 2
##    party all_pending
##    <dbl> <lgl>      
##  1     1 FALSE      
##  2     2 FALSE      
##  3     3 TRUE       
##  4     4 TRUE       
##  5     5 FALSE      
##  6     6 FALSE      
##  7     7 FALSE      
##  8     8 TRUE       
##  9     9 FALSE      
## 10    10 TRUE       
## 11    11 FALSE      
## 12    12 FALSE      
## 13    13 FALSE      
## 14    14 FALSE      
## 15    15 FALSE
```

4. Which parties still have a "PENDING" status for all members for the wedding?


```r
guest_long %>% 
  group_by(party) %>% 
  filter(event=='wedding') %>% 
  summarize(pending_wedding = all(attendance == "PENDING"))
```

```
## # A tibble: 15 x 2
##    party pending_wedding
##    <dbl> <lgl>          
##  1     1 FALSE          
##  2     2 FALSE          
##  3     3 TRUE           
##  4     4 TRUE           
##  5     5 FALSE          
##  6     6 FALSE          
##  7     7 FALSE          
##  8     8 TRUE           
##  9     9 FALSE          
## 10    10 TRUE           
## 11    11 FALSE          
## 12    12 FALSE          
## 13    13 FALSE          
## 14    14 FALSE          
## 15    15 FALSE
```


5. Put the data back to the way it was.


```r
guest_long %>% 
  pivot_wider(names_from = c(event),
              values_from = c(attendance, meal))
```

```
## # A tibble: 30 x 8
##    party name  attendance_wedd… attendance_brun… attendance_golf meal_wedding
##    <dbl> <chr> <chr>            <chr>            <chr>           <chr>       
##  1     1 Somm… PENDING          PENDING          PENDING         PENDING     
##  2     1 Phil… CONFIRMED        CONFIRMED        CONFIRMED       vegetarian  
##  3     1 Blan… CONFIRMED        CONFIRMED        CONFIRMED       chicken     
##  4     1 Emaa… PENDING          PENDING          PENDING         PENDING     
##  5     2 Blai… CONFIRMED        CONFIRMED        CONFIRMED       chicken     
##  6     2 Nige… CANCELLED        CANCELLED        CANCELLED       <NA>        
##  7     3 Sine… PENDING          PENDING          PENDING         PENDING     
##  8     4 Ayra… PENDING          PENDING          PENDING         vegetarian  
##  9     5 Atla… PENDING          PENDING          PENDING         PENDING     
## 10     5 Denz… CONFIRMED        CONFIRMED        CONFIRMED       fish        
## # … with 20 more rows, and 2 more variables: meal_brunch <chr>, meal_golf <chr>
```





6. You also have a list of emails for each party, in this worksheet under the 
   object `email`. Change this so that each person gets their own row. 
   Use `tidyr::separate_rows()`


```r
email %>% 
  separate_rows(guest, sep = ",")
```

```
## # A tibble: 28 x 2
##    guest              email              
##    <chr>              <chr>              
##  1 Sommer Medrano     sommm@gmail.com    
##  2 " Phillip Medrano" sommm@gmail.com    
##  3 " Blanka Medrano"  sommm@gmail.com    
##  4 " Emaan Medrano"   sommm@gmail.com    
##  5 Blair Park         bpark@gmail.com    
##  6 " Nigel Webb"      bpark@gmail.com    
##  7 Sinead English     singlish@hotmail.ca
##  8 Ayra Marks         marksa42@gmail.com 
##  9 Jolene Welsh       jw1987@hotmail.com 
## 10 " Hayley Booker"   jw1987@hotmail.com 
## # … with 18 more rows
```




## Exercise 3: Making tibbles

1. Create a tibble that has the following columns:

- A `label` column with `"Sample A"` in its entries.
- 100 random observations drawn from the N(0,1) distribution in the column `x`
  - "N" means the normal distribution. "(0, 1)" means mean = 0, sd = 1.
  - Use `rnorm()`
- `y` calculated as the `x` values + N(0,1) error. 


```r
n <- 100
tibble(label = "Sample A",
             x = rnorm(n),
             y = x + sd(x))
```

```
## # A tibble: 100 x 3
##    label          x      y
##    <chr>      <dbl>  <dbl>
##  1 Sample A -0.681   0.358
##  2 Sample A -0.448   0.591
##  3 Sample A -0.213   0.826
##  4 Sample A -0.0922  0.947
##  5 Sample A  0.535   1.57 
##  6 Sample A -0.839   0.200
##  7 Sample A  0.414   1.45 
##  8 Sample A -0.816   0.223
##  9 Sample A  1.43    2.47 
## 10 Sample A -1.34   -0.303
## # … with 90 more rows
```


2. Generate a Normal sample of size 100 for each combination of the following 
means (`mu`) and standard deviations (`sd`).


```r
n <- 100
mu <- c(-5, 0, 5)
sd <- c(1, 3, 10)
nesting(mu = mu, sd = sd) %>% 
  group_by_all() %>% 
  mutate(z = list(rnorm(n, mu, sd))) %>% 
  unnest()
```

```
## # A tibble: 300 x 3
## # Groups:   mu, sd [3]
##       mu    sd     z
##    <dbl> <dbl> <dbl>
##  1    -5     1 -4.71
##  2    -5     1 -4.66
##  3    -5     1 -5.54
##  4    -5     1 -6.57
##  5    -5     1 -3.33
##  6    -5     1 -5.50
##  7    -5     1 -3.42
##  8    -5     1 -4.10
##  9    -5     1 -5.41
## 10    -5     1 -5.24
## # … with 290 more rows
```


3. Fix the `experiment` tibble below (originally defined in the documentation 
of the `tidyr::expand()` function) so that all three repeats are displayed for 
each person, and the measurements are kept. Some code is given, but it doesn't
quite work. It needs a few adjustments. What are they?


```r
experiment <- tibble(
  name = rep(c("Alex", "Robert", "Sam"), c(3, 2, 1)),
  trt  = rep(c("a", "b", "a"), c(3, 2, 1)),
  rep = c(1, 2, 3, 1, 2, 1),
  measurement_1 = runif(6),
  measurement_2 = runif(6)
)
experiment %>% expand(nesting(name, trt, rep)) 
```

```
## # A tibble: 6 x 3
##   name   trt     rep
##   <chr>  <chr> <dbl>
## 1 Alex   a         1
## 2 Alex   a         2
## 3 Alex   a         3
## 4 Robert b         1
## 5 Robert b         2
## 6 Sam    a         1
```
