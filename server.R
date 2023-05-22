function(input, output) {
      
    
  
#DITARO DI OVERVIEW
      output$covid.leaflet.map <- renderLeaflet({
        covid.sum <- covid.updated %>%
          group_by(state, longitude, latitude) %>% 
          summarise(cases = sum(cases))
        
        getColor <- function(covid.sum) {
          sapply(covid.sum$cases, function(cases) {
            if(cases <= 15000) {
              "white"
            } else if(cases <= 25000) {
              "green"
            } else if(cases <= 75000) {
              "yellow"
            } else if(cases <= 150000) {
              "orange"
            } else {
              "red"
            } })
        }
        
        icons <- awesomeIcons(
          icon = 'ios-close',
          iconColor = 'grey',
          library = 'ion',
          markerColor = getColor(covid.sum)
        )
        
        leaflet(covid.sum) %>% addTiles() %>%
          addAwesomeMarkers(~longitude, ~latitude, 
                            icon=icons,
                            label= ~paste('Bundesland: ', state),
                            popup = ~paste('Gesamte Fälle: ', as.character(cases)))
      })
  
  
      output$date.cases.total <- renderPlotly({
        date.cases <- covid.updated %>% 
          group_by(date) %>% 
          summarise(cases = sum(cases)) %>% 
          ggplot(aes(x = date,
                     y = cases,
                     text = glue("Daten: {date}
                              Fälle:{cases}"),
                     fill=cases)) + 
          scale_fill_gradient(low = "#c4c4c4", high = "black") + geom_col() +
          labs(y = "Fälle",
               x = NULL, 
               fill = "Fall") +
          theme_capstone
        ggplotly(date.cases, tooltip = "text")})
      
      
      output$date.deaths.total <- renderPlotly({    
        date.deaths <- covid.updated %>% 
          group_by(date) %>% 
          summarise(deaths = sum(deaths)) %>% 
          ggplot(aes(x = date,
                     y = deaths,
                     text = glue("Daten: {date}
                              Todesfälle:{deaths}"),
                     fill=deaths)) + 
          scale_fill_gradient(low = "red", high = "#6b0101") + geom_col() +
          labs(y = "Todesfälle",
               x = NULL, 
               fill = "Tod") +
          theme_capstone
        ggplotly(date.deaths, tooltip = "text")})
      
      output$date.recovered.total <- renderPlotly({   
        date.recovered <- covid.updated %>% 
          group_by(date) %>% 
          summarise(recovered = sum(recovered)) %>% 
          ggplot(aes(x = date,
                     y = recovered,
                     text = glue("Daten: {date}
                              gerettet:{recovered}"),
                     fill=recovered)) + 
          scale_fill_gradient(low = "green", high = "#016b1d") + geom_col() +
          labs(y = "Leute Gerettet werden",
               x = NULL, 
               fill = "gerettet") +
          theme_capstone
        ggplotly(date.recovered, tooltip = "text")})
      
      
      output$state.cases.total <- renderPlotly({
        state.cases <- covid.updated %>%
          group_by(state) %>%
          summarise(cases = sum(cases)) %>%
          arrange(desc(cases))
        
        monthly.cases <- state.cases %>%
          ggplot(aes(
            x = cases,
            y = reorder(state, cases),
            text = glue("{state}
                         Gesamte Fälle: {cases}")
          )) +
          geom_col(aes(fill = cases)) +
          scale_fill_gradient(low = "#c4c4c4", high = "black") +
          labs(x = NULL,
               y = NULL,
               fill = "Fall") +
          scale_y_discrete(labels = wrap_format(30)) +
          scale_x_continuous(labels = label_number(suffix = " Fall")) +
          theme_capstone
        
        ggplotly(monthly.cases, tooltip = "text")
        
      })
      
      output$state.deaths.total <- renderPlotly({
        state.deaths <- covid.updated %>%
          group_by(state) %>%
          summarise(deaths = sum(deaths)) %>%
          arrange(desc(deaths))
        
        monthly.deaths <- state.deaths %>%
          ggplot(aes(
            x = deaths,
            y = reorder(state, deaths),
            text = glue("{state}
                         Gesamte Todesfälle: {deaths}")
          )) +
          geom_col(aes(fill = deaths)) +
          scale_fill_gradient(low = "red", high = "#6b0101") +
          labs(x = NULL,
               y = NULL,
               fill = "Tod") +
          scale_y_discrete(labels = wrap_format(30)) +
          scale_x_continuous(labels = label_number(suffix = " Tod")) +
          theme_capstone
        
        ggplotly(monthly.deaths, tooltip = "text")
        
      })
      
      output$state.recovered.total <- renderPlotly({
        state.recovered <- covid.updated %>%
          group_by(state) %>%
          summarise(recovered = sum(recovered)) %>%
          arrange(desc(recovered))
        
        monthly.recovered <- state.recovered %>%
          ggplot(aes(
            x = recovered,
            y = reorder(state, recovered),
            text = glue("{state}
                         Gesamte gerettet werden: {recovered}")
          )) +
          geom_col(aes(fill = recovered)) +
          scale_fill_gradient(low = "green", high = "#016b1d") +
          labs(x = NULL,
               y = NULL,
               fill = "gerettete Leute") +
          scale_y_discrete(labels = wrap_format(30)) +
          scale_x_continuous(labels = label_number(suffix = ""),name = "Fälle") +
          theme_capstone
        
        ggplotly(monthly.recovered, tooltip = "text")
        
      })      

#THIS IS IN THE DATASET 
      output$data_covid <- renderDataTable({
        DT::datatable(data = covid.updated, options = list(scrollX = T))
      })
      

  #CASES
      output$monthly.cases <- renderPlotly({
      state.cases <- covid.updated %>%
      filter(month == input$month) %>%
      group_by(state) %>%
      summarise(cases = sum(cases)) %>%
      arrange(desc(cases))
    
    monthly.cases <- state.cases %>%
      ggplot(aes(
        x = cases,
        y = reorder(state, cases),
        text = glue("{state}
                         Gesamte Fälle: {cases}")
      )) +
      geom_col(aes(fill = cases)) +
      scale_fill_gradient(low = "#c4c4c4", high = "black") +
      labs(x = NULL,
           y = NULL,
           fill = "Fall") +
      scale_y_discrete(labels = wrap_format(30)) +
      scale_x_continuous(labels = label_number(suffix = " Fall")) +
      theme_capstone
    
    ggplotly(monthly.cases, tooltip = "text")
    
  })
     
      output$table_case <- renderDataTable({
        DT::datatable(data = cases.sum %>% filter(month == input$month), options = list(scrollX = T))
      })
      
  
  #DEATHS 
  output$monthly.deaths <- renderPlotly({
    state.deaths <- covid.updated %>%
      filter(month == input$month) %>%
      group_by(state) %>%
      summarise(deaths = sum(deaths)) %>%
      arrange(desc(deaths))
    
    monthly.deaths <- state.deaths %>%
      ggplot(aes(
        x = deaths,
        y = reorder(state, deaths),
        text = glue("{state}
                         Gesamte Todesfälle: {deaths}")
      )) +
      geom_col(aes(fill = deaths)) +
      scale_fill_gradient(low = "red", high = "#6b0101") +
      labs(x = NULL,
           y = NULL,
           fill = "Tod") +
      scale_y_discrete(labels = wrap_format(30)) +
      scale_x_continuous(labels = label_number(suffix = " Tod")) +
      theme_capstone
    
    ggplotly(monthly.deaths, tooltip = "text")
    
  })

  
  output$table_deaths <- renderDataTable({
    DT::datatable(data = deaths.sum %>% filter(month == input$month), options = list(scrollX = T))
  })
  
  #RECOVERED
  output$monthly.recovered <- renderPlotly({
    state.recovered <- covid.updated %>%
      filter(month == input$month) %>%
      group_by(state) %>%
      summarise(recovered = sum(recovered)) %>%
      arrange(desc(recovered))
    
    monthly.recovered <- state.recovered %>%
      ggplot(aes(
        x = recovered,
        y = reorder(state, recovered),
        text = glue("{state}
                         Gesamte gerettet werden: {recovered}")
      )) +
      geom_col(aes(fill = recovered)) +
      scale_fill_gradient(low = "green", high = "#016b1d") +
      labs(x = NULL,
           y = NULL,
           fill = "gerretet") +
      scale_y_discrete(labels = wrap_format(30)) +
      scale_x_continuous(labels = label_number(suffix = " Leute")) +
      theme_capstone
    
    ggplotly(monthly.recovered, tooltip = "text")
    
  })
  
  output$table_recovered <- renderDataTable({
    DT::datatable(data = recovered.sum %>% filter(month == input$month), options = list(scrollX = T))
  })
  

# AGE GROUP BASED  
  output$state.age.cases <- renderPlotly({
    state.age <- covid.updated %>% 
      filter(age_group %in% input$age_group) %>% 
      group_by(state,age_group) %>% 
      summarise(cases = sum(cases)) %>% 
      ggplot(aes(y = reorder(state, cases),
                 x = cases,
                 text = glue("{state}
                          Fälle:{cases}
                         Altersgruppe: {age_group}"),
                 fill=age_group)) + geom_col() +
      geom_col() +
      labs(y = NULL,
           x = "Fälle", 
           fill = "Alter") +
      theme_capstone
    ggplotly(state.age, tooltip = "text")
    
  })
  
  output$table_case_age <- renderDataTable({
    DT::datatable(data = cases.sum %>% filter(age_group %in% input$age_group), options = list(scrollX = T))
  })
  

  output$state.age.death <- renderPlotly({
    state.death.age <- covid.updated %>% 
      filter(age_group %in% input$age_group) %>% 
      group_by(state,age_group) %>% 
      summarise(deaths = sum(deaths)) %>% 
      ggplot(aes(y = reorder(state, deaths),
                 x = deaths,
                 text = glue("{state}
                          Todesfälle:{deaths}
                         Altersgruppe: {age_group}"),
                 fill=age_group)) + geom_col() +
      geom_col() +
      labs(y = NULL,
           x = "Todesfälle", 
           fill = "Alter") +
      theme_capstone
    ggplotly(state.death.age, tooltip = "text")
    
  })
  
  output$table_deaths_age <- renderDataTable({
    DT::datatable(data = deaths.sum %>% filter(age_group %in% input$age_group), options = list(scrollX = T))
  })
  
  
  
  output$state.age.recovered <- renderPlotly({
    state.recovered.age <- covid.updated %>% 
      filter(age_group %in% input$age_group) %>% 
      group_by(state,age_group) %>% 
      summarise(recovered = sum(recovered)) %>% 
      ggplot(aes(y = reorder(state, recovered),
                 x = recovered,
                 text = glue("{state}
                          gerettet:{recovered}
                         Altersgruppe: {age_group}"),
                 fill=age_group)) + geom_col() +
      geom_col() +
      labs(y = NULL,
           x = "Leute gerettet werden", 
           fill = "Alter") +
      theme_capstone
    ggplotly(state.recovered.age, tooltip = "text")
    
  })
  
  output$table_recovered_age <- renderDataTable({
    DT::datatable(data = recovered.sum %>% filter(age_group %in% input$age_group), options = list(scrollX = T))
  })
  
  
# GENDER BASED
  output$state.gender.cases <- renderPlotly({
    state.gender <- covid.updated %>% 
      filter(gender %in% input$gender) %>% 
      group_by(state,gender) %>% 
      summarise(cases = sum(cases)) %>% 
      ggplot(aes(y = reorder(state, cases),
                 x = cases,
                 text = glue("{state}
                          Fälle:{cases}
                         Geschlect: {gender}"),
                 fill=gender)) + geom_col() +
      geom_col() +
      labs(y = NULL,
           x = "Fälle", 
           fill = "Geschlecht") +
      theme_capstone
    ggplotly(state.gender, tooltip = "text")
    
  })
  
  output$table_case_gender <- renderDataTable({
    DT::datatable(data = cases.sum %>% filter(gender %in% input$gender), options = list(scrollX = T))
  })
  
  
  output$state.gender.death <- renderPlotly({
    state.death.gender <- covid.updated %>% 
      filter(gender %in% input$gender) %>% 
      group_by(state,gender) %>% 
      summarise(deaths = sum(deaths)) %>% 
      ggplot(aes(y = reorder(state, deaths),
                 x = deaths,
                 text = glue("{state}
                          Todesfälle:{deaths}
                         Geschlect: {gender}"),
                 fill=gender)) + 
      geom_col() +
      labs(y = NULL,
           x = "Todesfälle", 
           fill = "Geschlecht") +
      theme_capstone
    ggplotly(state.death.gender, tooltip = "text")
    
  })
  
  output$table_deaths_gender <- renderDataTable({
    DT::datatable(data = deaths.sum %>% filter(gender %in% input$gender), options = list(scrollX = T))
  })
  
  output$state.gender.recovered <- renderPlotly({
    state.recovered.gender <- covid.updated %>% 
      filter(gender %in% input$gender) %>% 
      group_by(state,gender) %>% 
      summarise(recovered = sum(recovered)) %>% 
      ggplot(aes(y = reorder(state, recovered),
                 x = recovered,
                 text = glue("{state}
                          gerettet:{recovered}
                         Geschlect: {gender}"),
                 fill=gender)) + geom_col() +
      geom_col() +
      labs(y = NULL,
           x = "Leute gerettet werden", 
           fill = "Geschlecht") +
      theme_capstone
    ggplotly(state.recovered.gender, tooltip = "text")
    
  })
  
  output$table_recovered_gender <- renderDataTable({
    DT::datatable(data = recovered.sum %>% filter(gender %in% input$gender), options = list(scrollX = T))
  })
  
  
  
}
