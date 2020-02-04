---
title: "cm005 Worksheet: Exploring Geometric Objects"
author: "Allie Choate"
date: "1/29/2020"
output: 
  html_document:
    keep_md: true
    theme: paper
---

## Preliminary

Begin by loading the required packages. If you don't have these installed (or don't know whether you have them installed), you can install them by executing the following code in your console:

Now run this code chunk to load the packages:




**Data:**

```r
gapminder<- gapminder
```



<!---The following chunk allows errors when knitting--->



## Exercise 1: Bar Chart Grammar (Together)

Consider the following plot. Don't concern yourself with the code at this point.


```r
gapminder %>% 
  filter(year == 2007) %>% 
  mutate(continent = fct_infreq(continent)) %>% 
  ggplot(aes(continent)) +
  geom_bar() +
  theme_bw()
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Fill in the seven grammar components for this plot.

| Grammar Component     | Specification |
|-----------------------|---------------|
| __data__              | `gapminder` |
| __aesthetic mapping__ | aes(x=continent, y=count) |
| __geometric object__  |  geom_bar() |
| scale                 | linear for y, scale_x_discrete |
| statistical transform | none |
| coordinate system     | default - rectangular |
| facetting             | none |



## Exercise 2: `ggplot2` Syntax (Your Turn)

The following is a tsibble (a special type of tibble containing time series data, which we'll see more of later), stored in the variable `mauna`, of CO$_2$ concentrations collected monthly at the Mauna Loa station.

Execute this code to store the data in `mauna`:


```r
(mauna <- tsibble::as_tsibble(co2) %>% 
   rename(month = index, conc = value))
```

```
## # A tsibble: 468 x 2 [1M]
##       month  conc
##       <mth> <dbl>
##  1 1959 Jan  315.
##  2 1959 Feb  316.
##  3 1959 Mar  316.
##  4 1959 Apr  318.
##  5 1959 May  318.
##  6 1959 Jun  318 
##  7 1959 Jul  316.
##  8 1959 Aug  315.
##  9 1959 Sep  314.
## 10 1959 Oct  313.
## # … with 458 more rows
```




### 2(a)

Produce a line chart showing the concentration over time. Specifically, the plot should have the following grammar components:

| Grammar Component     | Specification |
|-----------------------|---------------|
| __data__              | `mauna` |
| __aesthetic mapping__ | x: month, y: conc |
| __geometric object__  | lines |
| scale                 | linear |
| statistical transform | none |
| coordinate system     | rectangular |
| facetting             | none |

Fill in the blanks to obtain the plot:


```r
p<- ggplot(mauna, aes(x=conc, y=month)) +
  scale_x_continuous() +
  geom_line() +
  theme_classic() + labs(title="concentration over time")

p
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

```r
### apparently month should be on the x-axis?
p1<- ggplot(mauna, aes(x=month, y=conc)) +
  geom_line() +
  theme_classic() + 
  labs(title="concentration over time")
p1
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-4-2.png" style="display: block; margin: auto;" />

### 2(b)

It turns out that you're allowed to specify the aesthetic mappings in a `geom` layer instead of, or in addition to, in the `ggplot()` function, with the following rules:

- Aesthetics appearing in a `geom` layer apply only to that layer.
- If there are conflicting aesthetics in both the `ggplot()` function and the `geom` layer, the `geom` layer takes precedence.

The following code mistakenly puts the month variable on the y-axis. Fill in the `FILL_THIS_IN` so that you still obtain the same result as above.


<center>

```r
ggplot(mauna, aes(y = month)) +
  geom_line(aes(x = month, y=conc)) + ylab("co2 levels")
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />
</center>



<br><br>


### 2(c)

You can store the output of the plot in a variable, too. Store the plot from 2(a) in the variable named `p`, then add a layer to `p` that adds green points to the plot.


```r
p + geom_point(colour = "green", size=.1, alpha=.6)
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />


<br><br>

### 2(d)

What's wrong with the following code? Fix it.


```r
ggplot(gapminder, aes(x= gdpPercap, y=lifeExp)) +
  geom_point(col = "magenta",alpha = 0.1) +
  theme_classic() +
  scale_y_log10() + #optional
  xlim(0,60000)+
  labs(x="GDP Per Capita", y="Life Expectancy", title="Life Expectancy by Country GDP")
```

```
## Warning: Removed 5 rows containing missing values (geom_point).
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />



<br><br>



### 2(e) BONUS

So you're a ggplot2 pro? Then, let's see this plot adapted to polar coordinates. 

Specifically:

- angle is month (January through December)
- radius is CO$_2$ concentration

The plot should look like a spiral, or concentric circles. 


**Polar Coordinate Plot:**

```r
ggplot(mauna, aes(x=conc, y=month)) +
  geom_point(aes(colour = conc)) +
   scale_colour_gradient(low = "lightblue", high = "black")+
  coord_polar(theta="x") +
  labs(x= "C02 Concentration", y="Year", title="Polar Coordinate Plot", colour="C02")
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />


<br>


**Messing around with other pretty variations:**

```r
mauna$newyear<- format(as.Date(mauna$month, format="%d/%m/%Y"),"%Y")
ggplot(mauna, aes(x=conc, y=month, color=newyear)) +
    geom_point()+
coord_polar(theta="x") +
  labs(x= "C02 Concentration", y="Year", title="Polar Coordinate Plot", fill="Year")
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />



<br><br><br><br>

Using just the means of C02 across time - this probs isn't right lol. 

```r
#mauna$newyear<- as.numeric(mauna$newyear)

conc.mean<-round(tapply(mauna$conc, mauna$newyear, mean),4)
dat<- cbind.data.frame(paste0("19", 59:97), conc.mean)
names(dat)<- c("Year", "C02")
radius<- dat$Year
angle<- dat$C02

# plot
ggplot(dat, aes(x=Year, y=C02)) +
  geom_point(shape=3) +
  geom_spoke(aes(angle = angle, radius = radius)) +
  theme_classic() +
  coord_polar() +
  expand_limits(y = 0)
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />


<br><br>


**I made a bug**

```r
ggplot(dat, aes(x=C02, y=Year)) +
  geom_point() +
  geom_spoke(aes(angle = angle, radius = as.numeric(radius))) +
  labs(x="Concentration", y="Years") +
  theme_classic() 
```

<img src="plotting_participation_files/figure-html/unnamed-chunk-11-1.png" style="display: block; margin: auto;" />



