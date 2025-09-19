cat("Chargement des tests unitaires GIP SESAN...\n")

quick_demo_test <- function() {
  cat("=== TEST RAPIDE POUR DEMO ===\n")
  cat("Répertoire courant:", getwd(), "\n")
  
  tests_passed <- 0
  tests_total <- 8
  
  # Test 1: Dossier Python
  python_exists <- dir.exists("python/")
  cat("   ", if(python_exists) "✅" else "❌", "Dossier Python", if(python_exists) "OK" else "MANQUANT", "\n")
  if(python_exists) tests_passed <- tests_passed + 1
  
  # Test 2: Requirements Python
  req_exists <- file.exists("python/requirements.txt")
  cat("   ", if(req_exists) "✅" else "❌", "Requirements Python", if(req_exists) "OK" else "MANQUANT", "\n")
  if(req_exists) tests_passed <- tests_passed + 1
  
  # Test 3: Dossier R
  r_exists <- dir.exists("R/")
  cat("   ", if(r_exists) "✅" else "❌", "Dossier R", if(r_exists) "OK" else "MANQUANT", "\n")
  if(r_exists) tests_passed <- tests_passed + 1
  
  # Test 4: Dossier docs
  docs_exists <- dir.exists("docs/")
  cat("   ", if(docs_exists) "✅" else "❌", "Documentation", if(docs_exists) "OK" else "MANQUANT", "\n")
  if(docs_exists) tests_passed <- tests_passed + 1
  
  # Test 5: README
  readme_exists <- file.exists("README.md")
  cat("   ", if(readme_exists) "✅" else "❌", "README", if(readme_exists) "OK" else "MANQUANT", "\n")
  if(readme_exists) tests_passed <- tests_passed + 1
  
  # Test 6: app.R
  app_exists <- file.exists("app.R")
  cat("   ", if(app_exists) "✅" else "❌", "Application principale", if(app_exists) "OK" else "MANQUANT", "\n")
  if(app_exists) tests_passed <- tests_passed + 1
  
  # Test 7: Environnement Python
  venv_active <- Sys.getenv("VIRTUAL_ENV") != ""
  cat("   ", if(venv_active) "✅" else "❌", "Environnement virtuel Python", if(venv_active) "actif" else "inactif", "\n")
  if(venv_active) tests_passed <- tests_passed + 1
  
  # Test 8: Git
  git_exists <- dir.exists(".git")
  cat("   ", if(git_exists) "✅" else "❌", "Repository Git", if(git_exists) "OK" else "MANQUANT", "\n")
  if(git_exists) tests_passed <- tests_passed + 1
  
  # Résultat final
  success_rate <- (tests_passed / tests_total) * 100
  cat(paste0("\n🎯 RÉSULTAT: ", tests_passed, "/", tests_total, 
            " tests OK (", round(success_rate, 0), "%)\n"))
  
  if (success_rate >= 80) {
    cat("🎉 PROJET PRÊT POUR DÉMO !\n")
  } else {
    cat("⚠️ Quelques ajustements recommandés\n")
  }
  
  return(list(passed = tests_passed, total = tests_total, rate = success_rate))
}

cat("💡 Fichier chargé. Tapez quick_demo_test() pour lancer\n")
