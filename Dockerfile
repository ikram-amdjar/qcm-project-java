# --- ÉTAPE 0 : Compilation du projet (Nécessaire pour le Cloud) ---
# On utilise Maven pour transformer ton code source en fichier .jar directement sur Railway
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# --- TON CODE ADAPTÉ ---

# Étape 1 : Utiliser une image Java légère
FROM eclipse-temurin:17-jdk-alpine

# Étape 2 : Créer un dossier pour l'application
WORKDIR /app

# Étape 3 : Copier le fichier .jar généré
# On le récupère depuis l'étape 'build' ci-dessus au lieu de ton PC
COPY --from=build /app/target/*.jar app.jar

# Étape 4 : Exposer le port (Vérifie bien que ton projet utilise le 9090)
EXPOSE 9090

# Étape 5 : Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]