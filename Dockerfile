# Étape 1 : Build de l'application Angular
FROM node:20 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install -g @angular/cli && npm install

# Copier le reste du code source
COPY . .

# Compiler l'application Angular
RUN ng build --configuration=production

# Étape 2 : Servir les fichiers compilés avec NGINX
FROM nginx:alpine

# Copier la build Angular dans le dossier NGINX par défaut
COPY --from=build /app/dist/ /usr/share/nginx/html

# Copier une configuration NGINX personnalisée (optionnel)
# COPY nginx.conf /etc/nginx/nginx.conf

# Exposer le port HTTP par défaut
EXPOSE 80