---
title: "Worksheet 2 - cm008 Exercises: Fix the Plots"
author: "Allie Choate"
date: "1/30/2020"
output: 
  html_document:
    keep_md: true
    theme: paper
    code_folding: show
---



In this worksheet, we'll be looking at some erroneous plots and fixing them. 


The exercsies below include some data wrangling function. It's okay if you
aren't familiar with them all yet! We will get into a lot of them over the
next few weeks, but see if you can figure out what they are doing as you go.


```r
library(tidyverse)
library(gapminder)
library(ggridges)
library(scales)
library(ggplot2)
library(dplyr)
library(car)
```

<br>

## Exercise 1: Overlapping Points

Fix the overlapping data points problem in the following plot by adding an `alpha`
or `size` argument (attribution: ["R for data science"](https://r4ds.had.co.nz/data-visualisation.html)).


```r
ggplot(mpg, aes(cty, hwy)) + 
  geom_point(alpha=.4, size=.5, col="blue") +
  geom_smooth(method="lm", col="black", size=.2)
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

**Different option without using alpha or size of geom points:**

```r
ggplot(mpg, aes(x=cty, y=hwy)) + 
  geom_point(aes(colour = cty), size=.5) +
  geom_smooth(method="lm") 
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />


<br><br>


## Exercise 2: Line for each Country

Fix this plot so that it shows life expectancy over time with a separate line
_for each country_. 

Notice that we tried to use `group_by()`. We will cover that next week. But 
also notice that `ggplot2` ignores the grouping of a tibble!


```r
gapminder %>% 
  group_by(country) %>% 
  ggplot(aes(year, lifeExp, group=country))+
  geom_line(size=.2)
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />
<br><br>

## Exercise 3: More gdpPercap vs lifeExp

### 3(a) Facets

- Change the x-axis text to be in "comma format" with `scales::comma_format()`.
- Separate each continent into sub-panels.


```r
ggplot(gapminder, aes(gdpPercap, lifeExp)) +
  geom_point(alpha = 0.2) +
  scale_x_log10(labels = scales::comma_format()) + 
  facet_wrap(vars(continent), scales="free_y") +
  labs(x="GDP Per Capita", y="Life Expectancy", title="Life Expectancy by GDP Per Capita by Continent")
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />


<br><br>


### 3(b) Bubble Plot

- Put the plots in one row, and free up the axes (let them have different scales).
- Make a bubble plot by making the size of the points proportional to population. 
  - Try adding a `scale_size_area()` layer too (could also try `scale_radius()` 
    but that is not optimal for perception).
- Use `shape=21` to distinguish between `fill` (interior) and `color` (exterior). 



```r
gapminder %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp, size=pop, col=continent))+ 
  geom_point(alpha=0.5, shape=21,col="magenta", fill="lightblue")+
  facet_wrap(~ continent, nrow=1, scales = "free") +
  scale_size_area(labels = scales::comma_format()) +
  labs(y="Life Expectancy", x="GDP Per Capita", size="Population Size")+
 scale_x_log10(labels = scales::comma_format()) 
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

<br>

A list of shapes can be found [at the bottom of the `scale_shape` documentation](https://ggplot2.tidyverse.org/reference/scale_shape.html).

### 3(c) Size "not working"

Instead of alpha transparency, suppose you're wanting to fix the overplotting issue by plotting small points. Why is this not working? Fix it.


```r
ggplot(gapminder,aes(gdpPercap, lifeExp)) +
  geom_point(shape=20, size=.05)+
  scale_x_log10(labels = scales::dollar_format())
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />




## Exercise 4: Walking caribou

The following mock data set marks the (x,y) position of a caribou at four time points. 

- Fix the plot below so that it shows the path of the caribou. 
- Add an arrow with `arrow = arrow()`.
- Add the `time` label with `geom_text()`.


```r
tribble(
  ~time, ~x, ~y,
  1, 0.3, 0.3,
  2, 0.8, 0.7,
  3, 0.5, 0.9,
  4, 0.4, 0.5
) %>% 
  ggplot(aes(x, y)) + 
  geom_path(arrow = arrow()) +
  geom_text(aes(label = time), nudge_y = 0.1, nudge_x = -0.01) +
  labs(title="151 Rum")
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

<br><br>


## Exercise 5: Life expectancies in Africa

### 5(a) Unhiding the data

Fix the plot so that you can actually see the data points. 

There is also the problem of overlapping text in the x-axis labels. How could we solve that?


```r
gapminder %>% 
  filter(continent == "Americas") %>% 
  ggplot(aes(country, lifeExp)) + 
  geom_point(colour="turquoise") +
  geom_boxplot() +
  geom_jitter(alpha = 0.5, height = 0.2) +
  scale_x_discrete() +
  coord_flip(expand=TRUE) 
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

<br><br>

### 5(b) Ridgeplots

We're starting with the same plot as above, but instead of the points + boxplot, try a ridge plot instead using `ggridges::geom_density_ridges()`, and adjust the `bandwidth`.


```r
gapminder %>% 
  filter(continent == "Americas") %>% 
  ggplot(aes(lifeExp,country)) + 
  ggridges::geom_density_ridges(aes(x=lifeExp,y=country),bandwidth=1) +
  labs(x="Life Expectancy", y="Country") +
  theme_ridges()
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />


<br><br>

## Exercise 6: Bar plot madness

### 6(a) Colour and stacking madness

- Change the following plot so that it shows _proportion_ on the y-axis, not count.
- Change the x-axis so that it doesn't appear to be continuous.
  - Hint: Transform the variable!
- Also change the colors of the bar fills, as well as the lines.
- Put the bars for transmission side-by-side with their own colour.
- Capitalize the legend title.


```r
mtcars$cyl.fac <- as.factor(mtcars$cyl)
bleh<- mtcars %>% 
  mutate(Transmission = if_else(am == 0, "automatic", "manual")) %>% 
  ggplot(aes(fill = Transmission, x = cyl.fac, y = (..count..)/sum(..count..))) +
  geom_bar(position = "dodge", color = "gray", width = 0.5) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1L), name = "Percent") +
  scale_x_discrete(name = "Cylinders") +
scale_fill_discrete(name = "Transmission") + 
  theme_classic()
# adding color
bleh + scale_fill_brewer(palette=2)
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />

<br><br>


### 6(b) Bar heights already calculated

Here's the number of people having a certain hair colour from a sample of 592 people:


```r
(hair <- as_tibble(HairEyeColor) %>% 
  count(Hair, wt = n))
```

Fix the following bar plot so that it shows these counts.


```r
ggplot(hair, aes(x=Hair, y=n)) +
  geom_bar(stat="identity") #counts 
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />
<br><br>


## Exercise 7: Tiling

Here's the number of people having a certain hair and eye colour from a sample of 592 people:


```r
(hair_eye <- as_tibble(HairEyeColor) %>% 
  count(Hair, Eye, wt = n))
```

Fix the following plot so that it shows a filled-in square for each combination. 
_Hint:_ What's the title of this exercise?

By the way, `geom_count()` is like `geom_bar()`: it counts the number of overlapping points.



```r
ggplot(hair_eye, aes(Hair, Eye)) +
  geom_point(aes(colour = n)) +
geom_tile(aes(fill=n)) +
  labs(title="Hair x Eye Combinations", x="Hair Color", y="Eye Color") 
```

<img src="PlottingPractice_files/figure-html/unnamed-chunk-14-1.png" style="display: block; margin: auto;" />





<br><br><br>





***



<br><br><br>

## Additional take-home practice

If you'd like some practice, give these exercises a try

__Exercise 1__: Make a plot of `year` (x) vs `lifeExp` (y), with points coloured by continent. Then, to that same plot, fit a straight regression line to each continent, without the error bars. If you can, try piping the data frame into the `ggplot()` function.

__Exercise 2__: Repeat Exercise 1, but switch the _regression line_ and _geom\_point_ layers. How is this plot different from that of Exercise 1?

__Exercise 3__: Omit the `geom_point()` layer from either of the above two plots (it doesn't matter which). Does the line still show up, even though the data aren't shown? Why or why not?

__Exercise 4__: Make a plot of `year` (x) vs `lifeExp` (y), facetted by continent. Then, fit a smoother through the data for each continent, without the error bars. Choose a span that you feel is appropriate.

__Exercise 5__: Plot the population over time (year) using lines, so that each country has its own line. Colour by `gdpPercap`. Add alpha transparency to your liking. 

__Exercise 6__: Add points to the plot in Exercise 5.
