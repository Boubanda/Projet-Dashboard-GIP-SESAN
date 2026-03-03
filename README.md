# 🏥 Dashboard Parcours Patients - GIP SESAN

> **Projet de candidature Data Analyst** - Démonstration des compétences R, Shiny et analyse de données de santé

[![R](https://img.shields.io/badge/R-4.0+-276DC3?style=flat&logo=r&logoColor=white)](https://www.r-project.org/)
[![Shiny](https://img.shields.io/badge/Shiny-Dashboard-blue?style=flat)](https://shiny.rstudio.com/)
[![VS Code](https://img.shields.io/badge/VS_Code-Ready-007ACC?style=flat&logo=visual-studio-code)](https://code.visualstudio.com/)

---

## 🎯 Aperçu du Projet

Ce projet présente un **tableau de bord interactif** d'analyse des parcours patients, développé spécifiquement pour démontrer les compétences requises pour le poste d'**Alternant Data Analyst** 

### 🌟 Fonctionnalités Principales

- **📊 Dashboard R Shiny** multi-onglets avec visualisations interactives
- **🗺️ Carte géographique** des établissements franciliens 
- **🤝 Analyse de réseau** des collaborations entre professionnels
- **📈 Prédictions** et modélisation simple
- **⚙️ Architecture modulaire** optimisée pour VS Code

### 📸 Aperçu Visuel

```
🏠 Vue d'Ensemble     🗺️ Adoption Régionale     🔄 Parcours Patients
     ↓                        ↓                        ↓
  [Métriques KPI]         [Carte Leaflet]         [Délais d'accès]
  [Évolution temps]       [Taux adoption]         [Séquences soins]
  [Top établissements]    [Benchmarks]            [Suivi longitudinal]

🤝 Réseau Professionnel    📈 Indicateurs Clés
        ↓                        ↓
   [Graphe collaboratif]      [Tendances KPI]
   [Centralité réseau]        [Corrélations]
   [Communautés]              [Prédictions]
```

---

## 🚀 Démarrage Rapide

### 1️⃣ Prérequis

- **R** (version ≥ 4.0) : [Télécharger R](https://cran.r-project.org/)
- **VS Code** : [Télécharger VS Code](https://code.visualstudio.com/)
- **Extension R pour VS Code** : [R Extension](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r)

### 2️⃣ Installation Rapide

```bash
# 1. Cloner le projet
git clone [votre-repo-url]
cd gip-sesan-dashboard

# 2. Ouvrir dans VS Code
code .

# 3. Lancer le projet
# Dans la console R de VS Code :
source("run.R")
```

Le script `run.R` va automatiquement :
- ✅ Installer les packages R manquants
- ✅ Créer la structure de dossiers
- ✅ Valider l'environnement
- ✅ Lancer l'application sur `http://localhost:3838`

### 3️⃣ Alternative Manuelle

Si vous préférez un contrôle étape par étape :

```r
# Dans la console R de VS Code

# Installation des packages
packages <- c("shiny", "shinydashboard", "DT", "plotly", 
              "dplyr", "ggplot2", "leaflet", "igraph", "visNetwork")
install.packages(packages)

# Chargement de l'application
source("app.R")
```

---

## 📁 Structure du Projet

```
gip-sesan-dashboard/
│
├── 📄 README.md                    # Cette documentation
├── 🚀 app.R                        # Application Shiny principale
├── ⚙️ run.R                        # Script de lancement rapide
│
├── 📊 R/                           # Scripts R modulaires
│   ├── 01_data_generation.R        # Génération données simulées
│   ├── 02_data_processing.R        # Traitement et indicateurs
│   ├── 03_ui_modules.R            # Modules interface utilisateur
│   ├── 04_server_functions.R      # Logique serveur
│   └── 99_utils.R                 # Fonctions utilitaires
│
├── ⚙️ config/                      # Configuration
│   └── app_config.R               # Paramètres application
│
├── 📚 docs/                        # Documentation
│   ├── guide_presentation.md      # Guide entretien
│   └── methodologie.md           # Approche technique
│
├── 🎨 www/                         # Assets web
│   └── custom.css                # Styles personnalisés
│
├── 📂 data/                        # Données (auto-généré)
│   ├── raw/                       # Données brutes
│   ├── processed/                 # Données traitées
│   └── cache/                     # Cache performance
│
└── 📦 .gitignore                   # Fichiers ignorés Git
```

---

## 📊 Aperçu des Données

### 🎲 Données Simulées Réalistes

Le projet génère automatiquement des données cohérentes et réalistes :

- **👥 2 500 patients** avec profils démographiques réalistes (âge, sexe, pathologies)
- **👨‍⚕️ 150 professionnels** répartis sur 15 établissements franciliens
- **📅 ~12 000 consultations** sur 20 mois (janvier 2024 - septembre 2025)
- **🏥 15 établissements** : AP-HP, CHU, cliniques privées d'Île-de-France
- **⚕️ 15 spécialités** médicales avec pondération réaliste

### 🔍 Biais Temporels Intégrés

- **📈 Effet COVID** : Adoption téléconsultation plus importante post-mars 2024
- **📅 Saisonnalité** : Variations hivernales pour certaines pathologies
- **⏰ Patterns hebdos** : Moins de consultations vendredi après-midi
- **🔄 Cohérence parcours** : Médecine générale comme point d'entrée (70% des cas)

---

## 🎨 Fonctionnalités du Dashboard

### 🏠 Vue d'Ensemble
- **📊 KPI synthétiques** : Patients, professionnels, taux d'adoption
- **📈 Évolution temporelle** : Impact COVID sur téléconsultations
- **🏆 Top établissements** : Classement activité et satisfaction
- **🥧 Répartition spécialités** : Distribution des consultations

### 🗺️ Adoption Régionale
- **🌍 Carte interactive Leaflet** : 15 établissements géolocalisés
- **🎨 Heatmap adoption** : Gradients de couleur (40% à 95%)
- **📋 Tableau dynamique** : Tri et filtres sur toutes les métriques
- **🏆 Benchmarks** : Champions par catégorie

### 🔄 Parcours Patients
- **⏱️ Délais d'accès** : Temps moyen par spécialité (21j moyenne)
- **🔄 Séquences soins** : Top 10 des parcours les plus fréquents
- **📊 Suivi longitudinal** : Évolution satisfaction dans parcours longs
- **🔍 Parcours complexes** : Patients multi-spécialités (>3 étapes)

### 🤝 Réseau Professionnel
- **🕸️ Graphe interactif** : 150 professionnels, liens = patients partagés
- **📊 Centralité** : Métriques degré, proximité, intermédiarité
- **👥 Communautés** : Algorithme de Louvain (4 clusters détectés)
- **🎯 Top influenceurs** : Professionnels les plus centraux

### 📈 Indicateurs Clés
- **📊 Tendances temporelles** : Évolution mensuelle des KPI
- **🔗 Matrice corrélation** : Relations entre indicateurs
- **🔮 Prédictions** : Modèle linéaire simple (81% adoption fin 2025)
- **🎯 Tableau de bord exécutif** : Vue synthétique pour direction

---

## 🔧 Utilisation avec VS Code

### ⌨️ Raccourcis Essentiels

- **Ctrl+Enter** : Exécuter ligne/sélection R
- **Ctrl+Shift+`** : Terminal R intégré
- **F5** : Débogage interactif
- **Ctrl+Shift+P** : Palette de commandes

### 🔄 Workflow Recommandé

1. **Ouvrir `app.R`** dans VS Code
2. **Tester des portions** avec `Ctrl+Enter`
3. **Console R intégrée** pour expérimentations
4. **`source("run.R")`** pour lancer l'application complète
5. **Git intégré** pour versionner

### 🎨 Extensions Recommandées

- **R (Yuki Ueda)** : Support complet R + Shiny
- **GitLens** : Historique Git avancé
- **Bracket Pair Colorizer** : Lisibilité du code
- **Material Icon Theme** : Icônes plus claires

---

## 🧪 Tests et Validation

### ✅ Validation Automatique

```r
# Dans la console R
source("R/99_utils.R")
validate_app_config()        # Validation configuration
validate_patient_data(data)  # Validation données
```

### 🔍 Tests Manuels Recommandés

- [ ] Application lance sans erreur (port 3838)
- [ ] Tous les onglets s'affichent correctement  
- [ ] Graphiques interactifs fonctionnent (zoom, hover)
- [ ] Carte géographique responsive
- [ ] Réseau professionnel navigable
- [ ] Données cohérentes (âges 0-100, dates logiques)
- [ ] Performance acceptable (<5s chargement initial)

---

## 🎯 Valeur pour GIP SESAN

### 💼 Impact Métier Direct

- **📊 Pilotage Santélien** : Mesure adoption temps réel par établissement
- **🔄 Optimisation parcours** : Identification goulots d'étranglement  
- **🤝 Coordination professionnelle** : Visualisation réseaux de soins
- **📈 Aide décision** : KPI actionnables pour directeurs

### 🔬 Innovation Technique

- **🕸️ Analyse réseau social** : Rare dans dashboards santé
- **📊 Données temporelles** : Biais COVID intégrés
- **🏗️ Architecture scalable** : Modulaire, extensible, documentée
- **🎨 UX pensée métier** : Navigation intuitive pour non-techniques

### 📈 Extensions Possibles

- **🤖 Machine Learning** : Clustering patients, prédiction risques
- **🔗 API temps réel** : Intégration systèmes hospitaliers
- **📱 Mobile app** : Version smartphone professionnels
- **🧠 IA générative** : Recommandations parcours optimaux

---

## 🏆 Démonstration des Compétences

### 💻 Techniques Maîtrisées

| Compétence | Implémentation | Niveau |
|------------|----------------|---------|
| **R avancé** | dplyr, ggplot2, igraph | ⭐⭐⭐⭐⭐ |
| **R Shiny** | Dashboard multi-onglets | ⭐⭐⭐⭐⭐ |
| **Visualisation** | Plotly, Leaflet, visNetwork | ⭐⭐⭐⭐ |
| **Analyse réseau** | igraph, centralité, communautés | ⭐⭐⭐⭐ |
| **VS Code** | Workflow intégré, debug | ⭐⭐⭐⭐ |
| **Documentation** | README, guides, commentaires | ⭐⭐⭐⭐⭐ |

### 🎭 Soft Skills Illustrées

- **🚀 Autonomie** : Projet mené de A à Z sans supervision
- **🔍 Rigueur** : Tests, validation, gestion d'erreurs
- **💡 Innovation** : Approches créatives (réseau social, géolocalisation)
- **📝 Communication** : Documentation claire, présentation structurée
- **🎯 Vision produit** : UX pensée utilisateur final

---

## 🎤 Guide Présentation Entretien

### ⏱️ Structure Recommandée (15-20 min)

1. **🎯 Contexte & Objectifs** (2 min)
   - Mission GIP SESAN comprise
   - Lien direct avec offre alternance

2. **📱 Démonstration Live** (10 min)
   - Navigation fluide entre onglets
   - 3-4 insights métier clés
   - Points techniques forts

3. **🏗️ Architecture & Choix** (3-4 min)
   - Justification stack technique
   - Modularité et évolutivité

4. **💡 Valeur Ajoutée & Perspectives** (2-3 min)
   - Impact opérationnel GIP SESAN
   - Extensions possibles

### 🎯 Messages Clés

- **"Dashboard opérationnel"** vs slides théoriques
- **"Architecture pensée production"** vs prototype
- **"Compréhension enjeux santé"** vs technique pure
- **"Polyvalence démontrée"** vs mono-compétence

### 💡 Points Forts à Souligner

- **Projet concret fonctionnel** (pas juste des concepts)
- **Analyse réseau social** (rare chez candidats juniors)
- **Données réalistes** (biais temporels, distributions INSEE)
- **Documentation complète** (README, méthodologie, commentaires)

---

## 🔧 Maintenance et Évolution

### 📊 Monitoring Performance

```r
# Profiling simple
source("R/99_utils.R")
profile_function(generate_patient_data, n_patients = 1000)

# Cache pour optimiser
result <- simple_cache("donnees_principales", {
  generate_patient_data(n_patients = 2500)
})
```

### 🔄 Mise à Jour des Données

```r
# Sauvegarde avec horodatage
save_data_with_timestamp(donnees, "patients_data")

# Chargement de la version la plus récente
donnees <- load_latest_data("patients_data")

# Nettoyage automatique (garde les 5 derniers)
clean_old_files("data/processed", keep_last = 5)
```

### 📝 Logging

```r
# Log avec niveaux
log_message("Application démarrée", "INFO")
log_message("Données chargées", "WARNING") 
log_message("Erreur critique", "ERROR")
```

---

## 🆘 Résolution de Problèmes

### ❌ Problèmes Courants

**Application ne lance pas**
```r
# Vérifier packages
source("run.R")  # Installe automatiquement les manquants

# Ou manuellement :
install.packages(c("shiny", "shinydashboard", "plotly"))
```

**Port 3838 occupé**
```r
# Changer de port
options(shiny.port = 3839)
source("app.R")
```

**Graphiques non interactifs**
```r
# Vérifier plotly
install.packages("plotly")
library(plotly)
```

**Données incohérentes**
```r
# Validation
source("R/99_utils.R")
donnees <- generate_patient_data(n_patients = 100)  # Test plus petit
validation <- validate_patient_data(donnees)
print(validation)
```

### 🔧 Mode Debug

```r
# Activer debug mode
APP_CONFIG$debug_mode <- TRUE

# Profiling détaillé
if(APP_CONFIG$debug_mode) {
  debug_structure(donnees, "Données Patients")
}
```

---

## 📚 Ressources et Références

### 🔗 Documentation Technique

- [Guide méthodologique complet](docs/methodologie.md)
- [Guide de présentation entretien](docs/guide_presentation.md)
- [Configuration VS Code détaillée](config/app_config.R)

### 🌐 Liens Utiles

- [GIP SESAN - Site officiel](https://www.sesan.fr/)
- [R Shiny Documentation](https://shiny.rstudio.com/)
- [VS Code R Extension](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r)
- [Plotly R Documentation](https://plotly.com/r/)
- [Leaflet R Documentation](https://rstudio.github.io/leaflet/)

### 📖 Standards Métier

- **SNDS** : Système National des Données de Santé
- **ICD-10** : Classification internationale des maladies
- **RGPD** : Réglementation données personnelles
- **HL7 FHIR** : Standard d'échange données santé

---

## 🤝 Contribution et Contact

### 📧 Contact

**Auteur** : Candidat Data Analyst  
**Organisation** : Candidature GIP SESAN  
**Email** : [votre-email]  
**LinkedIn** : [votre-profil]  
**GitHub** : [votre-repo]

### 🔄 Évolutions Futures

Ce projet est conçu pour évoluer. Extensions envisagées :

- **Phase 2** : Intégration API temps réel
- **Phase 3** : Machine Learning avancé
- **Phase 4** : Mobile app native
- **Phase 5** : IA générative pour recommandations

### 📜 Licence

MIT License - Libre d'utilisation pour fins éducatives et professionnelles.

---

## 🏅 Remerciements

- **GIP SESAN** pour l'opportunité d'alternance
- **Communauté R** pour les packages extraordinaires
- **VS Code Team** pour l'excellent support R
- **OpenStreetMap** pour les données géographiques

---

## ✨ Conclusion

Ce projet démontre **exactement les compétences recherchées** par GIP SESAN :

✅ **Maîtrise technique** R/Shiny/analyses statistiques  
✅ **Compréhension enjeux** numérisation santé  
✅ **Capacité produire** dashboards opérationnels  
✅ **Vision architecturale** et documentation  
✅ **Polyvalence** et capacité d'apprentissage  

**L'objectif n'est pas la perfection, mais la démonstration du potentiel** à contribuer immédiatement aux missions de transformation numérique de la santé francilienne.


