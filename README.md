📄 Projet Final – Crypto Tracker Cloud (Terraform + DevOps avancé)

------------------------------------------------------------------------

🎯 Contexte

Votre équipe DevOps a reçu pour mission de développer une application
cloud de suivi des cryptomonnaies pour une startup fictive.

L’application doit permettre :

-   de suivre les 10 principales cryptos (par capitalisation),
-   de stocker l’historique des prix,
-   de donner une tendance d’investissement simplifiée,
-   d’envoyer des alertes en cas de forte variation.

Le projet doit être collaboratif : chaque membre de l’équipe est
responsable d’un domaine spécifique (infra, backend, frontend, CI/CD,
sécurité/monitoring).

Le déploiement doit être automatisé sur Azure avec Terraform et un
pipeline CI/CD (GitHub Actions ou Azure DevOps).

------------------------------------------------------------------------

📌 Objectifs

1.  Créer une infrastructure complète et sécurisée sur Azure avec
    Terraform (modules).
2.  Développer un backend API qui récupère les données crypto via une
    API publique (CoinGecko ou équivalent).
3.  Développer un frontend interactif affichant cryptos, graphiques et
    tendances.
4.  Mettre en place une base de données pour stocker l’historique des
    cours.
5.  Ajouter un système d’alertes automatiques en cas de forte variation
    (> 5% / 24h).
6.  Implémenter un pipeline CI/CD multi-environnements (dev, staging,
    prod).
7.  Intégrer sécurité et monitoring (Key Vault, observabilité, alertes
    applicatives).

------------------------------------------------------------------------

🏗️ Infrastructure attendue (Terraform)

-   1 Resource Group
-   1 App Service pour le backend (API crypto)
-   1 App Service ou Static Web App pour le frontend
-   1 Azure Database (PostgreSQL ou CosmosDB) pour l’historique des
    cryptos
-   1 Storage Account pour stocker le state Terraform
-   1 Azure Key Vault (gestion des secrets : DB password, clés API)
-   1 Azure Monitor / Log Analytics pour la supervision

👉 Code Terraform organisé en modules
réutilisables (app_service, database, monitoring, etc.).

------------------------------------------------------------------------

⚙️ Fonctionnalités applicatives

Backend (API)

-   Endpoint /cryptos → retourne les 10 cryptos principales avec :
    -   Nom
    -   Prix actuel
    -   Variation sur 24h
    -   Tendance (Hausse 🚀 ou Baisse 📉)
-   Endpoint /history/:crypto → retourne l’historique (7 jours)
-   Stockage périodique des prix en base de données

Frontend

-   Dashboard crypto avec :
    -   Tableau listant les 10 cryptos
    -   Graphiques dynamiques (prix, variations) via Chart.js/Recharts
    -   Filtre/recherche par crypto
    -   Comparaison entre 2 cryptos
    -   Widget “Top gagnant / Top perdant”
    -   Mode clair/sombre

Alerting & Monitoring

-   Alerte (mail ou Teams) si une crypto chute de plus de 5% en 24h
-   Alerte si le backend est indisponible
-   Logs et métriques visibles via Azure Monitor

------------------------------------------------------------------------

🛠️ CI/CD attendu

Chaque équipe doit choisir GitHub Actions ou Azure DevOps.

Étapes CI (sur chaque push/PR)

-   terraform fmt -check, terraform validate, terraform plan
-   Lint + tests du backend et du frontend
-   Build/test du frontend

Étapes CD (sur main ou après approbation)

-   terraform apply (protégé par validation manuelle)
-   Déploiement backend (API)
-   Déploiement frontend (site web)

Multi-environnements

-   Déploiement séparé pour dev, staging, prod
-   Secrets/variables gérés par Key Vault

------------------------------------------------------------------------

📂 Organisation attendue

    crypto-tracker/
      infra/
        main.tf
        variables.tf
        outputs.tf
        modules/
          app_service/
          database/
          keyvault/
          monitoring/
      backend/
        app.py (ou index.js)
        requirements.txt / package.json
        tests/
        Dockerfile
      frontend/
        src/
        package.json
        tests/
      pipelines/
        ci.yml
        cd-dev.yml
        cd-prod.yml
      docs/
        README.md
        architecture.md
        contribution.md
      .gitignore

------------------------------------------------------------------------

✅ Livrables

1.  Code complet du projet (infra + backend + frontend).
2.  Pipelines CI/CD configurés et fonctionnels.
3.  Documentation complète avec :
    -   Instructions de déploiement Terraform
    -   Explication des pipelines CI/CD
    -   Description backend + frontend
    -   Screenshots du dashboard crypto
    -   Architecture et organisation de l’équipe

------------------------------------------------------------------------

🏆 Critères d’évaluation

-   ✅ Infra Terraform fonctionnelle et modulaire
-   ✅ Backend API fonctionnelle (avec DB)
-   ✅ Frontend complet et interactif
-   ✅ CI/CD avec plusieurs environnements
-   ✅ Monitoring + alertes opérationnels
-   ✅ Sécurité appliquée (Key Vault, secrets protégés)
-   ✅ Code propre et bien organisé
-   ✅ Collaboration GitHub (PR, branches, reviews)
-   ✅ Documentation claire et détaillée
