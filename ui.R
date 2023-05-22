header <- dashboardHeader(title = "Covid-19 Dashboard", titleWidth = 187)

sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(
    text = "Home",
    tabName = "home",
    icon = icon("home")
  ),
  
  menuItem(
    text = "Überblick",
    tabName = "overview",
    icon = icon("chart-line")
  ),
  
  menuItem(
    text = "Datensatz",
    icon = icon("database"),
    menuSubItem(
      text = "Tabelle",
      tabName = "data",
      icon = icon("table")),
    menuSubItem(
      text = "Link",
      href = "https://www.kaggle.com/headsortails/covid19-tracking-germany",
      icon = icon("download"))
    ),
  
  menuItem(
    text = "Monatlich Basiert",
    icon = icon("calendar-alt"),
    selectInput(
      inputId = "month",
      label = "Monat auswählen:",
      choices = levels(covid.updated$month)),
         menuSubItem(
           text = "Fallen",
           tabName = "cases1",
           icon = icon("virus")),
         menuSubItem(
           text = "Todesfälle",
           tabName = "deaths1",
           icon = icon("skull-crossbones")),
         menuSubItem(
           text = "Gerettet",
           tabName = "recovered1",
           icon = icon("heart"))
    ),
  
  menuItem(
    text = "Altersgruppe Basiert",
    icon = icon("user-friends"),
    checkboxGroupInput(
      inputId = "age_group",
      label = "Altersgruppe(n) auswählen:",
      choices = levels(covid.updated$age_group)),
    menuSubItem(
      text = "Fallen",
      tabName = "cases2",
      icon = icon("virus")),
    menuSubItem(
      text = "Todesfälle",
      tabName = "deaths2",
      icon = icon("skull-crossbones")),
    menuSubItem(
      text = "Gerettet",
      tabName = "recovered2",
      icon = icon("heart"))
  ),
  
  menuItem(
    text = "Geschlecht Basiert",
    icon = icon("transgender"),
    checkboxGroupInput(
      inputId = "gender",
      label = "Geschlecht(er) auswählen:",
      choices = unique(covid.updated$gender)),
    menuSubItem(
      text = "Fallen",
      tabName = "cases3",
      icon = icon("virus")),
    menuSubItem(
      text = "Todesfälle",
      tabName = "deaths3",
      icon = icon("skull-crossbones")),
    menuSubItem(
      text = "Gerettete",
      tabName = "recovered3",
      icon = icon("heart"))
  )
))





body <- dashboardBody(
  tabItems(
#HOME
    tabItem(
      tabName = "home",
      h1("DEUTSCHLAND 2020 COVID-19 DATEN", align = "center"),
      h2("Herzlich Willkommen zu unserem Data Visualization Projekt!", align = "left"),
      img(src="covid.JPG", width="80%"),
      h1("° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ", align = "center"),
      h2("ÜBERBLICK: ", align = "left"),
      img(src="mask.jpg", width="60%"),
      h4("Dieses Projekt ......", align = "left"),
      h1("° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° °  ", align = "center"),
      h2("STUDENTEN: ", align = "left"),
      h4("Eunice Stacy Tiolamon - Matrikelnummer:  ", align = "left"),
      h4("Tristan Hein - Matrikelnummer:  ", align = "left"),
      h4("Mihabat Khairi Aeido - Matrikelnummer:  ", align = "left"),
),





#OVERVIEW
    tabItem(    
      fluidRow(
      valueBox("1,323,923", "Fälle", color = "black"),
      valueBox("21,935", "Todesfälle", icon = icon("skull-crossbones"), color = "red"),
      valueBox("976,142", "Gerettete", icon = icon("heart"), color = "green")),
      tabName = "overview",
         h1("Kartenübersicht in jedem Bundesland", align = "center"),
         leafletOutput(outputId = "covid.leaflet.map"),
         h2("Farbe:", align = "left"),
         h4("-Schwarz: Fälle über 150.000", align = "left"),
         h4("-Rot: Fälle von 75.000 bis 150.000", align = "left"),
         h4("-Orange: Fälle von 75.000 bis 150.000", align = "left"),
         h4("-Green: Fälle von 25.000 bis 75.000", align = "left"),
         h4("-White: Fälle bis 25.000", align = "left"),
      h1("° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° °  ", align = "center"),
      h2("Fälle pro Tag", align = "center"),
        h4("Fälle", align = "center"),
         plotlyOutput(outputId = "date.cases.total"),
        h4("Todesfälle ", align = "center"),
         plotlyOutput(outputId = "date.deaths.total"),
        h4("Gerettete", align = "center"),
         plotlyOutput(outputId = "date.recovered.total"),
      h1("° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° °  ", align = "center"),
      h2("Fälle pro Bundesland", align = "center"),
        h4("Fälle je Bundesland", align = "center"),
         plotlyOutput(outputId = "state.cases.total"),
        h4("Todesfälle je Bundesland", align = "center"),
         plotlyOutput(outputId = "state.deaths.total"),
        h4("Gerettete Leute je Bundesland", align = "center"),
         plotlyOutput(outputId = "state.recovered.total"),
     # h1("° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° °  ", align = "center"),
     # h2("...", align = "center"),
     #    plotlyOutput(outputId = "total.gender"),
     #    plotlyOutput(outputId = "total.age"),
      h1("° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° ° °  ", align = "center"),
      h3("ENDE VOM ÜBERBLICK", align = "center")
         ),    


#DATASET    
    tabItem(tabName = "data",
            h1("Deutschlands Covid-19 Original-Datensatz im 2020", align = "center"),
            dataTableOutput(outputId = "data_covid")),    

#MONTHLY
 #   tabItem(
 #     tabName = "age",
 #     h1("Age Group Data on the Chosen Month in Germany", align = "center"),
 #     plotlyOutput(outputId = "monthly.age"),
 #     h3("Germany's Covid-19 Total Age Group Table on Chosen Month in 2020", align = "left"),
 #     dataTableOutput(outputId = "table_age")),
 #   
 #   tabItem(
 #     tabName = "gender",
 #     h1("Gender Data on the Chosen Month in Germany", align = "center"),
 #     plotlyOutput(outputId = "monthly.gender"),
 #     h3("Germany's Covid-19 Total Gender Table on Chosen Month in 2020", align = "left"),
 #     dataTableOutput(outputId = "table_gender")),

    tabItem(
      tabName = "cases1",
      h1("Gesamte Fallen für jedes Bundesland aus dem ausgewählte Monat", align = "center"),
      plotlyOutput(outputId = "monthly.cases"),
      h3("Die Tabelle der Gesamte Fallen für jedes Bundesland aus dem ausgewählte Monat", align = "left"),
      dataTableOutput(outputId = "table_case")),
    
    tabItem(
      tabName = "deaths1",
      h1("Gesamte Todesfälle für jedes Bundesland aus dem ausgewählte Monat", align = "center"),
      plotlyOutput(outputId = "monthly.deaths"),
      h3("Die Tabelle der Gesamte Todesfälle für jedes Bundesland aus dem ausgewählte Monat", align = "left"),
      dataTableOutput(outputId = "table_deaths")),
    
    tabItem(
      tabName = "recovered1",
      h1("Gesamte Leute gerettet werden für jedes Bundesland aus dem ausgewählte Monat", align = "center"),
      plotlyOutput(outputId = "monthly.recovered"),
      h3("Die Tabelle der Gesamte Gerettet für jedes Bundesland aus dem ausgewählte Monat", align = "left"),
      dataTableOutput(outputId = "table_recovered")),
   
# AGE GROUP BASED
  tabItem(
    tabName = "cases2",
    h1("Gesamte Fallen für jedes Bundesland aus der ausgewählte Altersgruppe(n)", align = "center"),
    plotlyOutput(outputId = "state.age.cases"),
    h3("Gesamte Fallen für jedes Bundesland aus der ausgewählte Altersgruppe(n)", align = "left"),
    dataTableOutput(outputId = "table_case_age")),
    

  tabItem(
    tabName = "deaths2",
    h1("Gesamte Todesfälle für jedes Bundesland aus der ausgewählte Altersgruppe(n)", align = "center"),
    plotlyOutput(outputId = "state.age.death"),
    h3("Gesamte Todesfälle für jedes Bundesland aus der ausgewählte Altersgruppe(n)", align = "left"),
    dataTableOutput(outputId = "table_deaths_age")),
  
  tabItem(
    tabName = "recovered2",
    h1("Gesamte Leute gerettet werden für jedes Bundesland aus der ausgewählte Altersgruppe(n)", align = "center"),
    plotlyOutput(outputId = "state.age.recovered"),
    h3("Gesamte Gerettet für jedes Bundesland aus der ausgewählte Altersgruppe(n)", align = "left"),
    dataTableOutput(outputId = "table_recovered_age")),

  

# GENDER BASED
  tabItem(
    tabName = "cases3",
    h1("Gesamte Fallen für jedes Bundesland aus dem ausgewählte Geschlecht(er)", align = "center"),
    plotlyOutput(outputId = "state.gender.cases"),
    h3("Gesamte Fallen für jedes Bundesland aus dem ausgewählte Geschlecht(er)", align = "left"),
    dataTableOutput(outputId = "table_case_gender")),
  
  tabItem(
    tabName = "deaths3",
    h1("Gesamte Todesfälle für jedes Bundesland aus dem ausgewählte Geschlecht(er)", align = "center"),
    plotlyOutput(outputId = "state.gender.death"),
    h3("Gesamte Todesfälle für jedes Bundesland aus dem ausgewählte Geschlecht(er)", align = "left"),
    dataTableOutput(outputId = "table_deaths_gender")),
  
  tabItem(
    tabName = "recovered3",
    h1("Gesamte Leute gerettet werden für jedes Bundesland aus dem ausgewählte Geschlecht(er)", align = "center"),
    plotlyOutput(outputId = "state.gender.recovered"),
    h3("Gesamte Gerettet für jedes Bundesland aus dem ausgewählte Geschlecht(er)", align = "left"),
    dataTableOutput(outputId = "table_recovered_gender"))
  
  ))

dashboardPage(
  header = header,
  body = body,
  sidebar = sidebar,
  skin = "black"
)
