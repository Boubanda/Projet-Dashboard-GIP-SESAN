# ===============================================================================
# CONFIGURATION DE L'APPLICATION - DASHBOARD GIP SESAN
# ===============================================================================
# Ce fichier contient tous les paramètres configurables de l'application
# ===============================================================================

# ===== CONFIGURATION GÉNÉRALE =====

APP_CONFIG <- list(
  
  # Informations application
  app_name = "Dashboard Parcours Patients",
  app_version = "1.0.0",
  organization = "GIP SESAN",
  author = "Candidat Data Analyst",
  
  # Paramètres des données
  n_patients = 2500,
  n_professionnels = 150,
  n_etablissements = 15,
  start_date = as.Date("2024-01-01"),
  end_date = as.Date("2025-08-31"),
  
  # Paramètres Shiny
  shiny_port = 3838,
  shiny_host = "127.0.0.1",
  max_upload_size = 30, # MB
  
  # Paramètres de performance
  cache_enabled = TRUE,
  debug_mode = FALSE,
  
  # Couleurs du thème
  colors = list(
    primary = "#3498db",
    success = "#27ae60", 
    warning = "#f39c12",
    danger = "#e74c3c",
    info = "#17a2b8",
    dark = "#2c3e50",
    light = "#ecf0f1"
  )
)

# ===== CONFIGURATION DES DONNÉES =====

DATA_CONFIG <- list(
  
  # Établissements de santé franciliens
  etablissements = c(
    "AP-HP Pitié-Salpêtrière",
    "AP-HP Cochin", 
    "AP-HP Saint-Louis",
    "Hôpital Européen Georges Pompidou",
    "Institut Gustave Roussy",
    "CHU Henri Mondor",
    "Hôpital Foch (Suresnes)",
    "Hôpital Américain",
    "Clinique du Mousseau",
    "Centre Hospitalier de Meaux",
    "CH de Versailles",
    "Hôpital Louis Mourier",
    "Hôpital Tenon",
    "Hôpital Lariboisière",
    "Centre Hospitalier Sud Essonne"
  ),
  
  # Spécialités médicales
  specialites = c(
    "Médecine générale",
    "Cardiologie", 
    "Dermatologie",
    "Pneumologie",
    "Neurologie",
    "Gastroentérologie",
    "Rhumatologie",
    "Endocrinologie",
    "Gynécologie",
    "Pédiatrie",
    "Psychiatrie",
    "Ophtalmologie",
    "ORL",
    "Radiologie",
    "Anesthésie"
  ),
  
  # Types d'actes médicaux
  types_actes = c(
    "Consultation",
    "Contrôle", 
    "Bilan",
    "Suivi",
    "Urgence",
    "Intervention",
    "Diagnostic",
    "Thérapie",
    "Prévention",
    "Rééducation"
  ),
  
  # Pathologies chroniques
  pathologies = c(
    "Aucune",
    "Diabète",
    "HTA", 
    "Asthme",
    "Dépression",
    "Arthrose",
    "Insuffisance cardiaque"
  )
)

# ===== CONFIGURATION DE L'INTERFACE =====

UI_CONFIG <- list(
  
  # Paramètres des graphiques
  plot_height = 400,
  plot_height_large = 500,
  map_height = 500,
  network_height = 500,
  
  # Paramètres des tableaux
  table_page_length = 15,
  table_dom = "Bfrtip",
  
  # Messages utilisateur
  loading_message = "Chargement en cours...",
  error_message = "Une erreur est survenue",
  no_data_message = "Aucune donnée disponible",
  
  # Paramètres de pagination
  items_per_page = 10,
  max_items_display = 1000
)

# ===== CONFIGURATION DES MÉTRIQUES =====

METRICS_CONFIG <- list(
  
  # Seuils d'alerte
  seuils = list(
    taux_adoption_excellent = 85,
    taux_adoption_bon = 70,
    taux_adoption_moyen = 50,
    satisfaction_excellente = 8.5,
    satisfaction_bonne = 7.0,
    delai_optimal = 14, # jours
    delai_acceptable = 30
  ),
  
  # KPI principaux
  kpi_list = c(
    "taux_adoption",
    "satisfaction_moyenne", 
    "delai_moyen_acces",
    "nb_interactions_interpro",
    "taux_parcours_coordonnes"
  ),
  
  # Pondérations pour score global
  poids_score = list(
    adoption = 0.3,
    satisfaction = 0.25,
    coordination = 0.25,
    efficacite = 0.2
  )
)

# ===== CONFIGURATION DES VISUALISATIONS =====

VIZ_CONFIG <- list(
  
  # Palette de couleurs pour les graphiques
  color_palette = c(
    "#3498db", "#e74c3c", "#2ecc71", "#f39c12", 
    "#9b59b6", "#1abc9c", "#34495e", "#e67e22"
  ),
  
  # Configuration Plotly
  plotly_config = list(
    displayModeBar = TRUE,
    displaylogo = FALSE,
    modeBarButtonsToRemove = c(
      "pan2d", "select2d", "lasso2d", "resetScale2d"
    )
  ),
  
  # Configuration Leaflet
  leaflet_config = list(
    center_lat = 48.8566,
    center_lng = 2.3522,
    default_zoom = 10,
    min_zoom = 8,
    max_zoom = 15
  )
)

# ===== CONFIGURATION DU DÉPLOIEMENT =====

DEPLOY_CONFIG <- list(
  
  # Configuration shinyapps.io
  shinyapps = list(
    app_name = "parcours-patients-dashboard",
    account_name = "votre-compte",
    server = "shinyapps.io"
  ),
  
  # Fichiers à inclure dans le déploiement
  files_to_deploy = c(
    "app.R",
    "R/",
    "config/",
    "www/",
    "data/cache/"
  ),
  
  # Fichiers à exclure
  files_to_exclude = c(
    "data/raw/",
    "docs/",
    "tests/",
    ".git/",
    "*.Rproj"
  )
)

# ===== FONCTIONS UTILITAIRES DE CONFIGURATION =====

#' Récupère une valeur de configuration
#' @param section Section de configuration (APP_CONFIG, DATA_CONFIG, etc.)
#' @param key Clé de la valeur
#' @param default Valeur par défaut si non trouvée
get_config <- function(section, key, default = NULL) {
  config_list <- get(section, envir = .GlobalEnv)
  if(key %in% names(config_list)) {
    return(config_list[[key]])
  } else {
    return(default)
  }
}

#' Vérifie la validité de la configuration
validate_config <- function() {
  cat("🔍 Validation de la configuration...\n")
  
  # Vérifications basiques
  checks <- list(
    "Nombre de patients > 0" = APP_CONFIG$n_patients > 0,
    "Nombre de professionnels > 0" = APP_CONFIG$n_professionnels > 0,
    "Dates cohérentes" = APP_CONFIG$start_date < APP_CONFIG$end_date,
    "Port valide" = APP_CONFIG$shiny_port >= 1000 && APP_CONFIG$shiny_port <= 9999,
    "Établissements définis" = length(DATA_CONFIG$etablissements) > 0,
    "Spécialités définies" = length(DATA_CONFIG$specialites) > 0
  )
  
  # Affichage des résultats
  for(check_name in names(checks)) {
    status <- if(checks[[check_name]]) "✅" else "❌"
    cat("", status, check_name, "\n")
  }
  
  # Retour global
  all_valid <- all(unlist(checks))
  if(all_valid) {
    cat("✅ Configuration valide\n")
  } else {
    cat("❌ Erreurs de configuration détectées\n")
  }
  
  return(all_valid)
}

#' Affiche un résumé de la configuration
print_config_summary <- function() {
  cat("\n📋 RÉSUMÉ DE LA CONFIGURATION\n")
  cat("="*40, "\n")
  cat("Application:", APP_CONFIG$app_name, "v", APP_CONFIG$app_version, "\n")
  cat("Organisation:", APP_CONFIG$organization, "\n")
  cat("Patients:", APP_CONFIG$n_patients, "\n")
  cat("Professionnels:", APP_CONFIG$n_professionnels, "\n")
  cat("Période:", APP_CONFIG$start_date, "au", APP_CONFIG$end_date, "\n")
  cat("Port Shiny:", APP_CONFIG$shiny_port, "\n")
  cat("="*40, "\n")
}

# ===== INITIALISATION =====

# Validation automatique au chargement
if(exists("APP_CONFIG") && interactive()) {
  validate_config()
}

# Message de chargement
cat("⚙️ Configuration chargée avec succès\n")