# Étape 1 : Utiliser une image Java légère
FROM eclipse-temurin:17-jdk-alpine

# Étape 2 : Créer un dossier pour l'application
WORKDIR /app

# Étape 3 : Copier le fichier .jar généré par Maven dans le conteneur
# On utilise un "wildcard" (*) pour attraper le fichier jar même si le nom change un peu
COPY target/*.jar app.jar

# Étape 4 : Exposer le port 8080 (port par défaut de Spring Boot)
EXPOSE 9090

# Étape 5 : Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]