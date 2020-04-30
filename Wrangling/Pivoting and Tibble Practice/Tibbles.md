---
title: "s07 Exercises: Tibble Joins"
author: "Allie Choate"
output: 
  html_document:
    keep_md: true
    theme: cerulean
---

## Requirements

Load required packages:



<!-- The following chunk allows errors when knitting -->





You will need data from Joey Bernhardt's `singer` R package for this exercise. 

You can download the singer data from the `USF-Psych-DataSci/Classroom` repo:


```r
songs <- read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/songs.csv")
locations <- read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/loc.csv")
```





## Exercise 1: `singer`

The package `singer` comes with two smallish data frames about songs. 
Let's take a look at them (after minor modifications by renaming and shuffling):


```r
(time <- as_tibble(songs) %>% 
   rename(song = title))
```

```
## # A tibble: 22 x 3
##    song                             artist_name      year
##    <chr>                            <chr>           <dbl>
##  1 Corduroy                         Pearl Jam        1994
##  2 Grievance                        Pearl Jam        2000
##  3 Stupidmop                        Pearl Jam        1994
##  4 Present Tense                    Pearl Jam        1996
##  5 MFC                              Pearl Jam        1998
##  6 Lukin                            Pearl Jam        1996
##  7 It's Lulu                        The Boo Radleys  1995
##  8 Sparrow                          The Boo Radleys  1992
##  9 Martin_ Doom! It's Seven O'Clock The Boo Radleys  1995
## 10 Leaves And Sand                  The Boo Radleys  1993
## # … with 12 more rows
```


```r
(album <- as_tibble(locations) %>% 
   select(title, everything()) %>% 
   rename(album = release,
          song  = title))
```

```
## # A tibble: 14 x 4
##    song                          artist_name    city        album               
##    <chr>                         <chr>          <chr>       <chr>               
##  1 "Grievance"                   Pearl Jam      Seattle, WA Binaural            
##  2 "Stupidmop"                   Pearl Jam      Seattle, WA Vitalogy            
##  3 "Present Tense"               Pearl Jam      Seattle, WA No Code             
##  4 "MFC"                         Pearl Jam      Seattle, WA Live On Two Legs    
##  5 "Lukin"                       Pearl Jam      Seattle, WA Seattle Washington …
##  6 "Stuck On Amber"              The Boo Radle… Liverpool,… Wake Up!            
##  7 "It's Lulu"                   The Boo Radle… Liverpool,… Best Of             
##  8 "Sparrow"                     The Boo Radle… Liverpool,… Everything's Alrigh…
##  9 "High as Monkeys"             The Boo Radle… Liverpool,… Kingsize            
## 10 "Butterfly McQueen"           The Boo Radle… Liverpool,… Giant Steps         
## 11 "My One and Only Love"        Carly Simon    New York, … Moonlight Serenade  
## 12 "It Was So Easy  (LP Version… Carly Simon    New York, … No Secrets          
## 13 "I've Got A Crush On You"     Carly Simon    New York, … Clouds In My Coffee…
## 14 "Manha De Carnaval (Theme fr… Carly Simon    New York, … Into White
```


1. We really care about the songs in `time`. But, for which of those songs do we 
   know its corresponding album?


```r
time %>% 
  inner_join(album, by = "song")
```

```
## # A tibble: 13 x 6
##    song               artist_name.x   year artist_name.y  city     album        
##    <chr>              <chr>          <dbl> <chr>          <chr>    <chr>        
##  1 "Grievance"        Pearl Jam       2000 Pearl Jam      Seattle… Binaural     
##  2 "Stupidmop"        Pearl Jam       1994 Pearl Jam      Seattle… Vitalogy     
##  3 "Present Tense"    Pearl Jam       1996 Pearl Jam      Seattle… No Code      
##  4 "MFC"              Pearl Jam       1998 Pearl Jam      Seattle… Live On Two …
##  5 "Lukin"            Pearl Jam       1996 Pearl Jam      Seattle… Seattle Wash…
##  6 "It's Lulu"        The Boo Radle…  1995 The Boo Radle… Liverpo… Best Of      
##  7 "Sparrow"          The Boo Radle…  1992 The Boo Radle… Liverpo… Everything's…
##  8 "High as Monkeys"  The Boo Radle…  1998 The Boo Radle… Liverpo… Kingsize     
##  9 "Butterfly McQuee… The Boo Radle…  1993 The Boo Radle… Liverpo… Giant Steps  
## 10 "My One and Only … Carly Simon     2005 Carly Simon    New Yor… Moonlight Se…
## 11 "It Was So Easy  … Carly Simon     1972 Carly Simon    New Yor… No Secrets   
## 12 "I've Got A Crush… Carly Simon     1994 Carly Simon    New Yor… Clouds In My…
## 13 "Manha De Carnava… Carly Simon     2007 Carly Simon    New Yor… Into White
```




2. Go ahead and add the corresponding albums to the `time` tibble, being sure to 
   preserve rows even if album info is not readily available.


```r
me<-time %>% 
  full_join(album, by = "artist_name")
# this example either one works, but left_join better to go with for future datasets
ansley<-time %>% 
  left_join(album, by = "artist_name")

suckitansley<-me == suckitansley
```

```
## Error in eval(expr, envir, enclos): object 'suckitansley' not found
```

```r
sum(isFALSE(suckitansley))
```

```
## Error in isFALSE(suckitansley): object 'suckitansley' not found
```



3. Which songs do we have "year", but not album info?


```r
time %>% 
  anti_join(album, by = "song")
```

```
## # A tibble: 9 x 3
##   song                             artist_name      year
##   <chr>                            <chr>           <dbl>
## 1 Corduroy                         Pearl Jam        1994
## 2 Martin_ Doom! It's Seven O'Clock The Boo Radleys  1995
## 3 Leaves And Sand                  The Boo Radleys  1993
## 4 Comb Your Hair                   The Boo Radleys  1998
## 5 Mine Again                       Mariah Carey     2005
## 6 Don't Forget About Us            Mariah Carey     2005
## 7 Babydoll                         Mariah Carey     1997
## 8 Don't Forget About Us            Mariah Carey     2005
## 9 Vision Of Love                   Mariah Carey     1990
```



4. Which artists are in `time`, but not in `album`?


```r
time %>% 
  anti_join(album, by = "artist_name")
```

```
## # A tibble: 5 x 3
##   song                  artist_name   year
##   <chr>                 <chr>        <dbl>
## 1 Mine Again            Mariah Carey  2005
## 2 Don't Forget About Us Mariah Carey  2005
## 3 Babydoll              Mariah Carey  1997
## 4 Don't Forget About Us Mariah Carey  2005
## 5 Vision Of Love        Mariah Carey  1990
```


5. You've come across these two tibbles, and just wish all the info was 
   available in one tibble. What would you do?


```r
time %>% 
  full_join(album, by = c("song","artist_name"))
```

```
## # A tibble: 23 x 5
##    song                  artist_name     year city         album                
##    <chr>                 <chr>          <dbl> <chr>        <chr>                
##  1 Corduroy              Pearl Jam       1994 <NA>         <NA>                 
##  2 Grievance             Pearl Jam       2000 Seattle, WA  Binaural             
##  3 Stupidmop             Pearl Jam       1994 Seattle, WA  Vitalogy             
##  4 Present Tense         Pearl Jam       1996 Seattle, WA  No Code              
##  5 MFC                   Pearl Jam       1998 Seattle, WA  Live On Two Legs     
##  6 Lukin                 Pearl Jam       1996 Seattle, WA  Seattle Washington N…
##  7 It's Lulu             The Boo Radle…  1995 Liverpool, … Best Of              
##  8 Sparrow               The Boo Radle…  1992 Liverpool, … Everything's Alright…
##  9 Martin_ Doom! It's S… The Boo Radle…  1995 <NA>         <NA>                 
## 10 Leaves And Sand       The Boo Radle…  1993 <NA>         <NA>                 
## # … with 13 more rows
```

```r
# or could use 'select'and drop album_name from x
```





## Exercise 2: LOTR

Load in three tibbles of data on the Lord of the Rings:


```r
fell <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
retk <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

1. Combine these into a single tibble.


```r
bind_rows(fell, ttow, retk)
```

```
## # A tibble: 9 x 4
##   Film                       Race   Female  Male
##   <chr>                      <chr>   <dbl> <dbl>
## 1 The Fellowship Of The Ring Elf      1229   971
## 2 The Fellowship Of The Ring Hobbit     14  3644
## 3 The Fellowship Of The Ring Man         0  1995
## 4 The Two Towers             Elf       331   513
## 5 The Two Towers             Hobbit      0  2463
## 6 The Two Towers             Man       401  3589
## 7 The Return Of The King     Elf       183   510
## 8 The Return Of The King     Hobbit      2  2673
## 9 The Return Of The King     Man       268  2459
```

```r
unique(fell$Race)
```

```
## [1] "Elf"    "Hobbit" "Man"
```

2. Which races are present in "The Fellowship of the Ring" (`fell`), but not in 
   any of the other ones?


```r
fell %>% 
  anti_join(ttow, by = "Race") %>% 
  anti_join(retk, by = "Race")
```

```
## # A tibble: 0 x 4
## # … with 4 variables: Film <chr>, Race <chr>, Female <dbl>, Male <dbl>
```


## Exercise 3: Set Operations

Let's use three set functions: `intersect`, `union` and `setdiff`. We'll work 
with two toy tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet


```r
(y <-  tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
```


```r
(z <- tibble(x1 = c("B", "C", "D"), x2 = 2:4))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
## 3 D         4
```

1. Rows that appear in both `y` and `z`


```r
semi_join(y, z) 
```

```
## Joining, by = c("x1", "x2")
```

```
## # A tibble: 2 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
```

```r
# or intersect()
```


2. You collected the data in `y` on Day 1, and `z` in Day 2. 
   Make a data set to reflect that.


```r
new.dat<-bind_rows(
  mutate(y, day = "Day 1"),
  mutate(z, day = "Day 2")
)
new.dat
```

```
## # A tibble: 6 x 3
##   x1       x2 day  
##   <chr> <int> <chr>
## 1 A         1 Day 1
## 2 B         2 Day 1
## 3 C         3 Day 1
## 4 B         2 Day 2
## 5 C         3 Day 2
## 6 D         4 Day 2
```

3. The rows contained in `z` are bad! Remove those rows from `y`.


```r
setdiff(y, z)
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
```

```r
#base R if dataset is saved as an object
new.dat[-c(4:6),]
```

```
## # A tibble: 3 x 3
##   x1       x2 day  
##   <chr> <int> <chr>
## 1 A         1 Day 1
## 2 B         2 Day 1
## 3 C         3 Day 1
```





```r
library(nycflights13)
```



