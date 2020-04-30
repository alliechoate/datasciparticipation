library(gapminder)
library(tidyverse)
library(readxl)
library(here)
library(haven)
library(svglite)
library(ggplot2)

#reading in data and exporting out as a .csv file
(gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia"))
write_csv(gap_asia_2007, "exported_file.csv")



#xls_url <- "http://gattonweb.uky.edu/sheather/book/docs/datasets/GreatestGivers.xls"
#download.file(xls_url, here::here("data", "s008_data", "some_file.xls"), mode = "wb")

# useful for reading in files without necessairily specifying the entire path name
    # good for switching between computers 
test<-read_csv(here::here("data", "s008_data", "exported_file.csv"))
(clevel <- haven::read_spss(here::here("data", "s008_data", "clevel.sav")))

# cleaning the data up a bit to get ready to plot
clevel_cleaned <-
  clevel %>% 
  mutate(language = as_factor(language),
         gender = as_factor(gender),
         isClevel = factor(isClevel, 
                           levels = c(0, 1), 
                           labels = c("No", "Yes"))
  ) %>% 
  print()




clevel_plot <-
  clevel_cleaned %>% 
  mutate(isClevel = recode(isClevel, 
                           No = "Below C-level", 
                           Yes = "C-level"),
         gender = recode(gender,
                         Female = "Women",
                         Male = "Men")) %>% 
  ggplot(aes(paste(isClevel, gender, sep = "\n"), Extraversion, color = gender)) +
  geom_boxplot() +
  geom_jitter(height = .2) +
  scale_color_manual(values = c("#1b9e77", "#7570b3")) +
  ggtitle("Extraversion Stan Scores") +
  scale_y_continuous(breaks = 1:9) +
  ggthemes::theme_fivethirtyeight() %>% 
  print()
write_csv(clevel_cleaned, here::here("data", "s008_data", "clevel_cleaned.csv"))

clevel_plot #view plot


### saving plot using 'ggsave' -- brenton recommends .svg files. 
  # need 300 dpi minimum for picture resolution. 
    # common imagge formats = .tif (highest quality - no image compression)
    # png - usually for posting online. smaller than tif, but could become a relatively big file w/ fine grained images


# the below makes a folder 'output' with a folder then in that folder called 'figures' ---then saves the below files. 
dir.create(here::here("output", "figures"), recursive = TRUE) #makes all folders in the path
ggsave(here::here("output", "figures", "clevel_extraversion.svg"), clevel_plot)






