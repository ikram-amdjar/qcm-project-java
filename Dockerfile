# --- ÉTAPE DE COMPILATION (Nouveau) ---
# Utiliser une image Maven pour construire le projet car le dossier target est ignoré par Git
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
# Copier les fichiers de configuration et le code source
COPY pom.xml .
COPY src ./src
# Lancer la compilation pour générer le fichier .jar
RUN mvn clean package -DskipTests

# --- ÉTAPE D'EXÉCUTION (Ton code adapté) ---
# Étape 1 : Utiliser une image Java légère
FROM eclipse-temurin:17-jdk-alpine

# Étape 2 : Créer un dossier pour l'application
WORKDIR /app

# Étape 3 : Copier le fichier .jar généré (On le prend depuis l'étape 'build' précédente)
COPY --from=build /app/target/*.jar app.jar

# Étape 4 : Exposer le port (Attention : vérifie que ton application.properties utilise bien 9090)
EXPOSE 9090

# Étape 5 : Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]