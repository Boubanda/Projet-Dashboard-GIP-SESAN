# GIP SESAN Dashboard - Version fonctionnelle
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(dplyr)

# Données santé numérique réalistes
health_data <- data.frame(
  region = rep(c("Île-de-France", "PACA", "Auvergne-Rhône-Alpes", "Occitanie"), each = 12),
  mois = rep(1:12, 4),
  adoptions_dmp = c(
    sample(12000:18000, 12), # IDF - plus élevé
    sample(8000:12000, 12),  # PACA
    sample(6000:10000, 12),  # Auvergne
    sample(5000:9000, 12)    # Occitanie
  ),
  teleconsultations = c(
    sample(25000:35000, 12),
    sample(15000:25000, 12),
    sample(12000:20000, 12),
    sample(10000:18000, 12)
  ),
  satisfaction = runif(48, 3.2, 4.8)
)

ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "GIP SESAN Observatory"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Vue d'ensemble", tabName = "overview", icon = icon("dashboard")),
      menuItem("Adoption numérique", tabName = "adoption", icon = icon("chart-line")),
      menuItem("Analyses régionales", tabName = "regions", icon = icon("map"))
    )
  ),
  
  dashboardBody(
    includeCSS("www/custom.css"),
    
    tabItems(
      # Vue d'ensemble
      tabItem(tabName = "overview",
        fluidRow(
          valueBoxOutput("total_dmp", width = 3),
          valueBoxOutput("total_telecons", width = 3), 
          valueBoxOutput("avg_satisfaction", width = 3),
          valueBoxOutput("growth_rate", width = 3)
        ),
        fluidRow(
          box(plotlyOutput("trends_plot"), width = 8, title = "Évolution des adoptions"),
          box(plotlyOutput("satisfaction_gauge"), width = 4, title = "Satisfaction")
        )
      ),
      
      # Adoption numérique
      tabItem(tabName = "adoption",
        fluidRow(
          box(plotlyOutput("adoption_by_region"), width = 6, title = "DMP par région"),
          box(plotlyOutput("telecons_evolution"), width = 6, title = "Téléconsultations")
        ),
        fluidRow(
          box(DT::dataTableOutput("adoption_table"), width = 12, title = "Données détaillées")
        )
      ),
      
      # Analyses régionales
      tabItem(tabName = "regions",
        fluidRow(
          box(plotlyOutput("regional_comparison"), width = 12, title = "Comparaison régionale")
        )
      )
    )
  )
)

server <- function(input, output) {
  
  # KPIs
  output$total_dmp <- renderValueBox({
    total <- format(sum(health_data$adoptions_dmp), big.mark = " ")
    valueBox(total, "Adoptions DMP", icon = icon("id-card"), color = "blue")
  })
  
  output$total_telecons <- renderValueBox({
    total <- format(sum(health_data$teleconsultations), big.mark = " ")
    valueBox(total, "Téléconsultations", icon = icon("video"), color = "green")
  })
  
  output$avg_satisfaction <- renderValueBox({
    avg <- round(mean(health_data$satisfaction), 1)
    valueBox(paste0(avg, "/5"), "Satisfaction", icon = icon("star"), color = "yellow")
  })
  
  output$growth_rate <- renderValueBox({
    valueBox("+24%", "Croissance", icon = icon("arrow-up"), color = "green")
  })
  
  # Graphiques
  output$trends_plot <- renderPlotly({
    p <- ggplot(health_data, aes(x = mois, y = adoptions_dmp, color = region)) +
      geom_line(size = 1.2) + geom_point(size = 3) +
      scale_x_continuous(breaks = 1:12, labels = month.abb) +
      scale_y_continuous(labels = scales::comma_format()) +
      labs(title = "", x = "Mois", y = "Adoptions DMP", color = "Région") +
      theme_minimal() +
      theme(legend.position = "bottom")
    ggplotly(p)
  })
  
  output$satisfaction_gauge <- renderPlotly({
    plot_ly(
      domain = list(x = c(0, 1), y = c(0, 1)),
      value = round(mean(health_data$satisfaction), 1),
      title = list(text = "Moyenne"),
      type = "indicator",
      mode = "gauge+number",
      gauge = list(
        axis = list(range = list(NULL, 5)),
        bar = list(color = "darkgreen"),
        steps = list(
          list(range = c(0, 2.5), color = "lightgray"),
          list(range = c(2.5, 4), color = "yellow"),
          list(range = c(4, 5), color = "green")
        )
      )
    )
  })
  
  output$adoption_by_region <- renderPlotly({
    regional_totals <- health_data %>%
      group_by(region) %>%
      summarise(total_adoptions = sum(adoptions_dmp))
    
    p <- ggplot(regional_totals, aes(x = reorder(region, total_adoptions), y = total_adoptions)) +
      geom_bar(stat = "identity", fill = "steelblue", alpha = 0.8) +
      coord_flip() +
      labs(title = "", x = "", y = "Total adoptions DMP") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$telecons_evolution <- renderPlotly({
    monthly_telecons <- health_data %>%
      group_by(mois) %>%
      summarise(total_telecons = sum(teleconsultations))
    
    p <- ggplot(monthly_telecons, aes(x = mois, y = total_telecons)) +
      geom_line(color = "green", size = 1.5) + geom_point(color = "darkgreen", size = 3) +
      scale_x_continuous(breaks = 1:12, labels = month.abb) +
      labs(title = "", x = "Mois", y = "Téléconsultations") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$adoption_table <- DT::renderDataTable({
    DT::datatable(health_data, options = list(pageLength = 10))
  })
  
  output$regional_comparison <- renderPlotly({
    comparison_data <- health_data %>%
      group_by(region, mois) %>%
      summarise(ratio = teleconsultations / adoptions_dmp)
    
    p <- ggplot(comparison_data, aes(x = mois, y = ratio, fill = region)) +
      geom_bar(stat = "identity", position = "dodge") +
      scale_x_continuous(breaks = 1:12, labels = month.abb) +
      labs(title = "", x = "Mois", y = "Ratio Télécons/DMP", fill = "Région") +
      theme_minimal()
    ggplotly(p)
  })
}

shinyApp(ui, server)
