# ===============================================================================
# SCRIPT DE LANCEMENT RAPIDE - DASHBOARD GIP SESAN
# ===============================================================================
# Usage: source("run.R") dans la console R ou double-clic sur le fichier
# ===============================================================================

cat("🚀 LANCEMENT DASHBOARD GIP SESAN\n")
cat("="*50, "\n")

# ===== VÉRIFICATION ET INSTALLATION DES PACKAGES =====

required_packages <- c(
  "shiny", "shinydashboard", "DT", "plotly", 
  "dplyr", "tidyr", "ggplot2", "lubridate",
  "leaflet", "igraph", "visNetwork", 
  "shinycssloaders"
)

cat("📦 Vérification des packages...\n")

# Fonction d'installation
install_if_missing <- function(packages) {
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) {
    cat("⬇️  Installation des packages manquants:", paste(new_packages, collapse = ", "), "\n")
    install.packages(new_packages, dependencies = TRUE, repos = "https://cran.rstudio.com/")
    cat("✅ Installation terminée\n")
  } else {
    cat("✅ Tous les packages sont installés\n")
  }
}

# Installation des packages manquants
install_if_missing(required_packages)

# ===== CRÉATION DES DOSSIERS =====

cat("📁 Création de la structure de dossiers...\n")

folders <- c("data", "data/raw", "data/processed", "data/cache", 
            "www", "docs", "docs/screenshots")

for(folder in folders) {
  if(!dir.exists(folder)) {
    dir.create(folder, recursive = TRUE)
    cat("  📂 Créé:", folder, "\n")
  }
}

# ===== VÉRIFICATION DES FICHIERS =====

cat("🔍 Vérification des fichiers essentiels...\n")

essential_files <- c(
  "app.R",
  "config/app_config.R",
  "R/01_data_generation.R",
  "R/02_data_processing.R",
  "R/03_ui_modules.R",
  "R/04_server_functions.R"
)

missing_files <- essential_files[!file.exists(essential_files)]

if(length(missing_files) > 0) {
  cat("⚠️  Fichiers manquants:\n")
  for(file in missing_files) {
    cat("  ❌", file, "\n")
  }
  cat("\n💡 Créez ces fichiers avant de continuer\n")
  cat("📚 Consultez la documentation pour le contenu\n")
  stop("Fichiers manquants - arrêt du script")
} else {
  cat("✅ Tous les fichiers essentiels sont présents\n")
}

# ===== GÉNÉRATION DES ASSETS =====

cat("🎨 Création des assets...\n")

# CSS personnalisé simple
if(!file.exists("www/custom.css")) {
  css_content <- "
/* Styles personnalisés Dashboard GIP SESAN */
.content-wrapper {
  background-color: #f8f9fa;
}

.box {
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.value-box {
  border-radius: 8px;
}

.navbar-brand {
  font-weight: bold;
  color: #2c3e50 !important;
}

/* Amélioration des graphiques */
.plotly {
  border-radius: 6px;
}

/* Style pour les tableaux */
.dataTables_wrapper {
  margin-top: 10px;
}
"
  writeLines(css_content, "www/custom.css")
  cat("  🎨 CSS personnalisé créé\n")
}

# ===== INFORMATIONS SYSTÈME =====

cat("\n📋 INFORMATIONS SYSTÈME\n")
cat("-"*30, "\n")
cat("R version:", R.version.string, "\n")
cat("Plateforme:", R.version$platform, "\n")
cat("Dossier de travail:", getwd(), "\n")

# ===== LANCEMENT DE L'APPLICATION =====

cat("\n🚀 LANCEMENT DE L'APPLICATION\n")
cat("-"*35, "\n")
cat("🌐 Ouverture du dashboard dans le navigateur...\n")
cat("📍 URL: http://localhost:3838\n")
cat("⏹️  Pour arrêter: Ctrl+C dans la console\n\n")

# Options Shiny
options(
  shiny.launch.browser = TRUE,
  shiny.host = "127.0.0.1",
  shiny.port = 3838
)

# Gestion des erreurs
tryCatch({
  
  # Chargement de l'application
  if(file.exists("app.R")) {
    cat("📱 Chargement de app.R...\n")
    source("app.R")
  } else {
    stop("❌ Fichier app.R introuvable")
  }
  
}, error = function(e) {
  
  cat("\n❌ ERREUR LORS DU LANCEMENT\n")
  cat("="*35, "\n")
  cat("Message d'erreur:", e$message, "\n")
  cat("\n🔧 Solutions possibles:\n")
  cat("1. Vérifiez que tous les fichiers R sont présents\n")
  cat("2. Vérifiez que les packages sont bien installés\n")
  cat("3. Redémarrez R et relancez le script\n")
  cat("4. Consultez la documentation dans docs/\n")
  
})

cat("\n✨ Script terminé\n")