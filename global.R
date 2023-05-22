library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)
library(glue)
library(DT)
library(ggplot2)
library(leaflet)
#library(shinyBS)
#library(shinyjs)
#library(shinycssloaders)

covid <- read.csv("covid_de.csv", stringsAsFactors = TRUE)

date.formated <- as.Date(covid$date, format = "%Y-%m-%d")

covid.updated <- covid %>%
  mutate(month = as.factor(format(as.Date(date.formated), "%B")),
         month = factor(month, levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")),
         date = date.formated,
         month = factor(month, labels = c("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")),
         age_group = factor(age_group, levels = c("00-04", "05-14", "15-34", "35-59", "60-79", "80-99")),
         gender = ifelse(gender == "M", yes = "Männlich", no = "Weiblich")) %>%
  arrange(month) %>%
  relocate(month, .after = date) %>% 
  na.omit()

#colnames(covid.updated) <- str_to_title(colnames(covid.updated))

theme_capstone <- theme(
  legend.key = element_rect(fill = "white"),
  legend.background = element_rect(color = "black", 
                                   fill = "white"),
  #plot.subtitle = element_text(size = 10, color = "white")
  panel.background = element_rect(fill = "white"),
  panel.border = element_rect(fill = NA),
  panel.grid.minor.x = element_blank(),
  panel.grid.major.x = element_blank(),
  panel.grid.major.y = element_line(color = "black", linetype =
                                      2),
  panel.grid.minor.y = element_blank(),
  plot.background = element_rect(fill = "white"),
  text = element_text(color = "black"),
  axis.text = element_text(color = "black")
)

cases.sum <- covid.updated %>% 
  group_by(state, month, age_group, gender) %>% 
  summarise(cases = sum(cases))


deaths.sum <- covid.updated %>% 
  group_by(state, month, age_group, gender) %>% 
  summarise(deaths = sum(deaths))


recovered.sum <- covid.updated %>% 
  group_by(state, month, age_group, gender) %>% 
  summarise(recovered = sum(recovered))
