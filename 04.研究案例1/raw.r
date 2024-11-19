# https://mastering-shiny.org/basic-case-study.html
#----加载包---- 
library(shiny) 
library(vroom) # 用于快速文件读取
library(tidyverse)

setwd("04.研究案例1/")
#----下载数据----
# dir.create("neiss")
# #> Warning in dir.create("neiss"): 'neiss' already exists
# download <- function(name) {
#   url <- "https://raw.github.com/hadley/mastering-shiny/main/neiss/"
#   download.file(paste0(url, name), paste0("neiss/", name), quiet = TRUE)
# }
# download("injuries.tsv.gz")
# download("population.tsv")
# download("products.tsv")

#----加载数据----
injuries <- vroom::vroom("neiss/injuries.tsv.gz")
# view(injuries)
products <- vroom::vroom("neiss/products.tsv")
# view(products)
population <- vroom::vroom("neiss/population.tsv")
# view(population)

#----探索数据----
selected <- injuries %>% filter(prod_code == 649)
nrow(selected)

selected %>% count(location, wt = weight, sort = TRUE)
selected %>% count(body_part, wt = weight, sort = TRUE)
selected %>% count(diag, wt = weight, sort = TRUE)
summary <- selected %>% count(age, sex, wt = weight) %>% as.data.frame()
summary

# mac 版本可能会报错，改下这个就好；
# https://stackoverflow.com/questions/19513705/error-in-rstudiogd-shadow-graphics-device-error-r-error-4-r-code-execution
# In R Studio, navigate to Tools, Global, Graphics (top middle), set Backend to AGG*, Apply, Ok
summary %>% 
  ggplot(aes(age, n, colour = sex)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")

summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(population, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)
summary
summary %>% 
  ggplot(aes(age, rate, colour = sex)) + 
  geom_line(na.rm = TRUE) + 
  labs(y = "Injuries per 10,000 people")

selected %>% 
  sample_n(10) %>% 
  pull(narrative)




