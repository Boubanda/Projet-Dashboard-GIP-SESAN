# ===============================================================================
# CONFIGURATION DE DÉPLOIEMENT - DASHBOARD GIP SESAN
# ===============================================================================
# Configuration pour le déploiement sur différents environnements
# ===============================================================================

# ===== CONFIGURATION GÉNÉRALE DÉPLOIEMENT =====

DEPLOY_CONFIG <- list(
  
  # Informations générales
  app_name = "parcours-patients-dashboard",
  app_title = "Dashboard Parcours Patients - GIP SESAN",
  version = "1.0.0",
  author = "Candidat Data Analyst",
  
  # Environnements disponibles
  environments = c("development", "staging", "production"),
  
  # Configuration par défaut
  default_environment = "development",
  
  # Taille maximale des données
  max_data_size_mb = 50,
  max_upload_size_mb = 30,
  
  # Timeout configurations
  session_timeout_minutes = 30,
  computation_timeout_seconds = 120
)

# ===== CONFIGURATION SHINYAPPS.IO =====

SHINYAPPS_CONFIG <- list(
  
  # Informations compte
  account_name = "votre-compte-shinyapps",  # À personnaliser
  server_name = "shinyapps.io",
  
  # Configuration application
  app_settings = list(
    app_name = "gip-sesan-dashboard",
    app_title = "Dashboard Parcours Patients",
    
    # Ressources allouées
    instance_size = "small",  # small, medium, large, xlarge
    max_instances = 1,        # Nombre max d'instances
    min_instances = 0,        # Instances minimum (0 pour économiser)
    
    # Paramètres avancés
    connection_timeout = 60,
    read_timeout = 60,
    init_timeout = 120,
    idle_timeout = 300,
    
    # Variables d'environnement
    environment_vars = list(
      SHINY_LOG_LEVEL = "INFO",
      R_MAX_MEMORY = "1024M"
    )
  ),
  
  # Fichiers à inclure dans le déploiement
  files_to_include = c(
    "app.R",
    "config/app_config.R",
    "R/",
    "www/",
    "data/cache/"  # Seulement le cache, pas les données brutes
  ),
  
  # Fichiers à exclure du déploiement
  files_to_exclude = c(
    "data/raw/",
    "data/temp/",
    "logs/",
    "docs/",
    "python/",
    "tests/",
    ".git/",
    ".Rproj.user/",
    "*.Rproj",
    ".DS_Store",
    "Thumbs.db"
  )
)

# ===== CONFIGURATION DOCKER =====

DOCKER_CONFIG <- list(
  
  # Image de base
  base_image = "rocker/shiny:4.3.0",
  
  # Configuration container
  container_settings = list(
    port = 3838,
    memory_limit = "2G",
    cpu_limit = "1.0",
    
    # Variables d'environnement Docker
    environment = list(
      SHINY_LOG_STDERR = "1",
      SHINY_LOG_LEVEL = "INFO",
      APPLICATION_LOGS_TO_STDOUT = "true"
    )
  ),
  
  # Packages système nécessaires
  system_packages = c(
    "libssl-dev",
    "libcurl4-openssl-dev", 
    "libxml2-dev",
    "libgdal-dev",
    "libproj-dev"
  ),
  
  # Commandes personnalisées
  custom_commands = c(
    "RUN apt-get update && apt-get install -y libssl-dev",
    "RUN mkdir -p /srv/shiny-server/logs",
    "RUN chown -R shiny:shiny /srv/shiny-server"
  )
)

# ===== CONFIGURATION SERVEUR DÉDIÉ =====

SERVER_CONFIG <- list(
  
  # Configuration serveur
  server_settings = list(
    host = "0.0.0.0",
    port = 3838,
    
    # Sécurité
    allowed_origins = c("*"),  # À restreindre en production
    max_request_size = "30MB",
    
    # Performance
    worker_processes = 2,
    max_connections = 100,
    keepalive_timeout = 60
  ),
  
  # Configuration base de données (si nécessaire)
  database = list(
    enabled = FALSE,
    type = "postgresql",  # postgresql, mysql, sqlite
    host = "localhost",
    port = 5432,
    database = "gip_sesan_db",
    username = "shiny_user",
    password = Sys.getenv("DB_PASSWORD"),  # Variable d'environnement
    
    # Pool de connexions
    pool_size = 5,
    max_overflow = 10,
    timeout = 30
  ),
  
  # Configuration cache Redis (optionnel)
  redis = list(
    enabled = FALSE,
    host = "localhost",
    port = 6379,
    database = 0,
    password = Sys.getenv("REDIS_PASSWORD")
  )
)

# ===== CONFIGURATION MONITORING =====

MONITORING_CONFIG <- list(
  
  # Logs
  logging = list(
    enabled = TRUE,
    level = "INFO",  # DEBUG, INFO, WARNING, ERROR
    
    # Destination des logs
    log_to_file = TRUE,
    log_file = "logs/application.log",
    log_to_console = TRUE,
    
    # Rotation des logs
    rotate_logs = TRUE,
    max_log_size_mb = 10,
    max_log_files = 5
  ),
  
  # Métriques de performance
  metrics = list(
    enabled = TRUE,
    
    # Métriques à collecter
    track_user_sessions = TRUE,
    track_page_views = TRUE,
    track_errors = TRUE,
    track_performance = TRUE,
    
    # Stockage métriques
    metrics_file = "logs/metrics.json",
    metrics_retention_days = 30
  ),
  
  # Alertes
  alerts = list(
    enabled = FALSE,  # À activer en production
    
    # Seuils d'alerte
    memory_usage_threshold = 80,      # %
    cpu_usage_threshold = 80,         # %
    error_rate_threshold = 5,         # % sur 5 minutes
    response_time_threshold = 5000,   # millisecondes
    
    # Notifications
    email_alerts = FALSE,
    webhook_url = NULL
  )
)

# ===== FONCTIONS DE DÉPLOIEMENT =====

#' Prépare l'application pour le déploiement
#' @param environment Environnement cible (development, staging, production)
#' @param clean_before_deploy Nettoyer avant déploiement
prepare_deployment <- function(environment = "development", clean_before_deploy = TRUE) {
  
  cat("🚀 PRÉPARATION DU DÉPLOIEMENT\n")
  cat("="*40, "\n")
  cat("Environnement:", environment, "\n")
  
  # Validation de l'environnement
  if(!environment %in% DEPLOY_CONFIG$environments) {
    stop("❌ Environnement non supporté: ", environment)
  }
  
  # Nettoyage préalable
  if(clean_before_deploy) {
    cat("🧹 Nettoyage des fichiers temporaires...\n")
    clean_deployment_files()
  }
  
  # Validation de l'application
  cat("🔍 Validation de l'application...\n")
  if(!validate_app_for_deployment()) {
    stop("❌ Application non valide pour déploiement")
  }
  
  # Création du package de déploiement
  cat("📦 Création du package...\n")
  create_deployment_package(environment)
  
  cat("✅ Préparation terminée\n")
  return(TRUE)
}

#' Déploie sur shinyapps.io
#' @param force_update Forcer la mise à jour
deploy_to_shinyapps <- function(force_update = FALSE) {
  
  if(!require(rsconnect, quietly = TRUE)) {
    stop("❌ Package 'rsconnect' requis. Installer avec: install.packages('rsconnect')")
  }
  
  cat("🌐 DÉPLOIEMENT SUR SHINYAPPS.IO\n")
  cat("="*35, "\n")
  
  # Configuration du compte (si pas déjà fait)
  accounts <- rsconnect::accounts()
  if(nrow(accounts) == 0) {
    cat("⚙️ Configuration du compte requise\n")
    cat("Exécutez: rsconnect::setAccountInfo(name='votre-nom', token='votre-token', secret='votre-secret')\n")
    return(FALSE)
  }
  
  # Préparation
  prepare_deployment("production")
  
  # Déploiement
  tryCatch({
    rsconnect::deployApp(
      appName = SHINYAPPS_CONFIG$app_settings$app_name,
      appTitle = SHINYAPPS_CONFIG$app_settings$app_title,
      forceUpdate = force_update,
      launch.browser = TRUE
    )
    cat("✅ Déploiement réussi !\n")
    return(TRUE)
  }, error = function(e) {
    cat("❌ Erreur lors du déploiement:", e$message, "\n")
    return(FALSE)
  })
}

#' Génère un Dockerfile pour containerisation
generate_dockerfile <- function(output_path = "Dockerfile") {
  
  dockerfile_content <- paste0(
    "# Dockerfile généré automatiquement - Dashboard GIP SESAN\n",
    "FROM ", DOCKER_CONFIG$base_image, "\n\n",
    
    "# Installation des dépendances système\n",
    "RUN apt-get update && apt-get install -y \\\n",
    paste(paste0("    ", DOCKER_CONFIG$system_packages), collapse = " \\\n"), " \\\n",
    "    && apt-get clean \\\n",
    "    && rm -rf /var/lib/apt/lists/*\n\n",
    
    "# Installation des packages R\n",
    "RUN R -e \"install.packages(c('shiny', 'shinydashboard', 'DT', 'plotly', 'dplyr', 'ggplot2', 'leaflet', 'igraph', 'visNetwork', 'lubridate'), repos='https://cran.rstudio.com/')\"\n\n",
    
    "# Copie des fichiers de l'application\n",
    "COPY . /srv/shiny-server/\n\n",
    
    "# Configuration des permissions\n",
    "RUN chown -R shiny:shiny /srv/shiny-server\n\n",
    
    "# Variables d'environnement\n",
    paste0("ENV ", names(DOCKER_CONFIG$container_settings$environment), "=", 
           unlist(DOCKER_CONFIG$container_settings$environment), collapse = "\n"), "\n\n",
    
    "# Exposition du port\n",
    "EXPOSE ", DOCKER_CONFIG$container_settings$port, "\n\n",
    
    "# Commande de démarrage\n",
    "CMD [\"/usr/bin/shiny-server\"]\n"
  )
  
  writeLines(dockerfile_content, output_path)
  cat("🐳 Dockerfile généré:", output_path, "\n")
}

#' Nettoie les fichiers de déploiement
clean_deployment_files <- function() {
  
  files_to_clean <- c(
    "data/temp/",
    "data/raw/",
    "logs/",
    ".RData",
    ".Rhistory"
  )
  
  for(item in files_to_clean) {
    if(dir.exists(item)) {
      unlink(item, recursive = TRUE)
      cat("🗑️ Supprimé dossier:", item, "\n")
    } else if(file.exists(item)) {
      file.remove(item)
      cat("🗑️ Supprimé fichier:", item, "\n")
    }
  }
}

#' Valide l'application avant déploiement
validate_app_for_deployment <- function() {
  
  cat("🔍 Validation de l'application...\n")
  
  # Vérifications essentielles
  checks <- list(
    "app.R existe" = file.exists("app.R"),
    "Config chargée" = exists("APP_CONFIG"),
    "Modules R présents" = all(file.exists(c("R/01_data_generation.R", "R/02_data_processing.R"))),
    "CSS présent" = file.exists("www/custom.css"),
    "Packages disponibles" = all(c("shiny", "shinydashboard", "plotly") %in% installed.packages()[,"Package"])
  )
  
  # Affichage des résultats
  for(check_name in names(checks)) {
    status <- if(checks[[check_name]]) "✅" else "❌"
    cat("", status, check_name, "\n")
  }
  
  # Test rapide de chargement
  tryCatch({
    source("R/01_data_generation.R")
    test_data <- generate_patient_data(n_patients = 10)
    cat("✅ Test génération données réussi\n")
  }, error = function(e) {
    cat("❌ Erreur test données:", e$message, "\n")
    checks[["Test données"]] <- FALSE
  })
  
  all_valid <- all(unlist(checks))
  if(all_valid) {
    cat("✅ Application prête pour déploiement\n")
  } else {
    cat("❌ Corrections nécessaires avant déploiement\n")
  }
  
  return(all_valid)
}

#' Crée un package de déploiement
create_deployment_package <- function(environment = "production") {
  
  package_dir <- paste0("deploy_", environment, "_", format(Sys.time(), "%Y%m%d_%H%M%S"))
  
  if(!dir.exists(package_dir)) {
    dir.create(package_dir, recursive = TRUE)
  }
  
  # Copie des fichiers essentiels
  essential_files <- SHINYAPPS_CONFIG$files_to_include
  
  for(file in essential_files) {
    if(file.exists(file)) {
      if(dir.exists(file)) {
        file.copy(file, package_dir, recursive = TRUE)
      } else {
        file.copy(file, package_dir)
      }
      cat("📄 Copié:", file, "\n")
    }
  }
  
  # Création d'un README de déploiement
  deploy_readme <- paste0(
    "# Package de Déploiement - ", toupper(environment), "\n\n",
    "Généré le: ", format(Sys.time(), "%d/%m/%Y %H:%M:%S"), "\n",
    "Version: ", DEPLOY_CONFIG$version, "\n",
    "Environnement: ", environment, "\n\n",
    "## Fichiers inclus:\n",
    paste0("- ", essential_files, collapse = "\n"), "\n\n",
    "## Instructions:\n",
    "1. Vérifier que tous les fichiers sont présents\n",
    "2. Tester l'application localement\n",
    "3. Déployer sur la plateforme cible\n"
  )
  
  writeLines(deploy_readme, file.path(package_dir, "DEPLOY_README.md"))
  
  cat("📦 Package créé:", package_dir, "\n")
  return(package_dir)
}

#' Affiche le statut de déploiement
deployment_status <- function() {
  
  cat("\n📊 STATUT DE DÉPLOIEMENT\n")
  cat("="*30, "\n")
  
  # Informations générales
  cat("Application:", DEPLOY_CONFIG$app_name, "\n")
  cat("Version:", DEPLOY_CONFIG$version, "\n")
  cat("Environnement par défaut:", DEPLOY_CONFIG$default_environment, "\n")
  
  # Vérification des outils
  tools_status <- list(
    "rsconnect installé" = "rsconnect" %in% installed.packages()[,"Package"],
    "Docker disponible" = system("docker --version", ignore.stdout = TRUE, ignore.stderr = TRUE) == 0,
    "Git initialisé" = dir.exists(".git")
  )
  
  cat("\n🛠️ Outils disponibles:\n")
  for(tool in names(tools_status)) {
    status <- if(tools_status[[tool]]) "✅" else "❌"
    cat("", status, tool, "\n")
  }
  
  # Taille de l'application
  if(dir.exists(".")) {
    app_size <- sum(file.size(list.files(recursive = TRUE, full.names = TRUE)), na.rm = TRUE)
    app_size_mb <- round(app_size / 1024 / 1024, 2)
    cat("\n📏 Taille application:", app_size_mb, "MB\n")
    
    if(app_size_mb > DEPLOY_CONFIG$max_data_size_mb) {
      cat("⚠️ Application volumineuse - optimisation recommandée\n")
    }
  }
  
  cat("\n💡 Commandes utiles:\n")
  cat("• prepare_deployment('production')\n")
  cat("• deploy_to_shinyapps()\n")
  cat("• generate_dockerfile()\n")
  cat("• validate_app_for_deployment()\n")
}

# ===== INITIALISATION =====

# Chargement automatique de la configuration si en mode interactif
if(interactive()) {
  cat("🚀 Configuration de déploiement chargée\n")
  cat("💡 Utilisez deployment_status() pour voir les options disponibles\n")
}

# Export des fonctions principales
export_functions <- c(
  "prepare_deployment",
  "deploy_to_shinyapps", 
  "generate_dockerfile",
  "clean_deployment_files",
  "validate_app_for_deployment",
  "deployment_status"
)

cat("🔧 Fonctions de déploiement disponibles:\n")
for(func in export_functions) {
  cat("  •", func, "()\n")
}