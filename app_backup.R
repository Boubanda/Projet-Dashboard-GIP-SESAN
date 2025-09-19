# =====================================================================
# GIP SESAN DASHBOARD - APPLICATION PRINCIPALE
# =====================================================================
# Architecture professionnelle avec modules R + Python ML
# =====================================================================

# Chargement de la configuration
source("config/app_config.R")

# Chargement des modules R 
source("R/01_data_generation.R")
source("R/02_data_processing.R") 
source("R/03_ui_modules.R")
source("R/04_server_functions.R")
source("R/99_utils.R")

# Packages
library(shiny)
library(shinydashboard)
library(DT)
library(plotly)
library(leaflet)
library(dplyr)

# Interface utilisateur avancée
ui <- dashboardPage(
  skin = "blue",
  
  # En-tête avec branding GIP SESAN
  dashboardHeader(
    title = "GIP SESAN Observatory",
    tags$li(class = "dropdown",
            tags$a(href = "https://www.gip-sesan.fr", 
                   target = "_blank", "Site officiel"))
  ),
  
  # Menu latéral professionnel
  dashboardSidebar(
    sidebarMenu(
      menuItem("Vue d'ensemble", tabName = "overview", icon = icon("dashboard")),
      menuItem("Adoption numérique", tabName = "adoption", icon = icon("chart-line")),
      menuItem("Parcours patients", tabName = "parcours", icon = icon("user-md")),
      menuItem("Analyses géographiques", tabName = "geo", icon = icon("map-marked-alt")),
      menuItem("Machine Learning", tabName = "ml", icon = icon("brain")),
      menuItem("Rapport exécutif", tabName = "report", icon = icon("file-alt"))
    )
  ),
  
  # Corps principal avec modules
  dashboardBody(
    # CSS personnalisé
    includeCSS("www/custom.css"),
    
    tabItems(
      # Onglet vue d'ensemble
      tabItem(tabName = "overview",
              overview_module_ui("overview")
      ),
      
      # Onglet adoption
      tabItem(tabName = "adoption", 
              adoption_module_ui("adoption")
      ),
      
      # Onglet parcours
      tabItem(tabName = "parcours",
              parcours_module_ui("parcours") 
      ),
      
      # Onglet géo
      tabItem(tabName = "geo",
              geo_module_ui("geo")
      ),
      
      # Onglet ML
      tabItem(tabName = "ml",
              ml_module_ui("ml")
      ),
      
      # Rapport
      tabItem(tabName = "report",
              report_module_ui("report")
      )
    )
  )
)

# Serveur avec logique métier avancée
server <- function(input, output, session) {
  
  # Chargement des données réalistes
  health_data <- reactive({
    generate_realistic_health_data(APP_CONFIG$simulation_params)
  })
  
  # Modules serveur
  overview_module_server("overview", health_data)
  adoption_module_server("adoption", health_data)  
  parcours_module_server("parcours", health_data)
  geo_module_server("geo", health_data)
  ml_module_server("ml", health_data)
  report_module_server("report", health_data)
  
  # Intégration Python ML
  observe({
    if(input$run_python_analysis) {
      python_results <- run_python_enrichment(health_data())
      updateTabsetPanel(session, "main_tabs", selected = "ml")
    }
  })
}

# Lancement
shinyApp(ui = ui, server = server)
