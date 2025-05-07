# Étape 1 : Build Angular app
FROM node:18 AS angular-build
WORKDIR /app
COPY client ./client
WORKDIR /app/client

RUN echo "Démarrage du build Angular...2"
RUN npm install
RUN npm run build -- --configuration production --verbose || true

RUN mkdir /build

DIR /app
DIR /app/client
DIR /app/client/dist/
COPY /app/client/dist/tp02 /build

# Étape 2 : Préparer le backend Node.js
FROM node:18 AS api-build
WORKDIR /app
COPY api ./api
COPY --from=angular-build /app/client/dist/tp02 ./public  # copie du build Angular
WORKDIR /app/api
RUN npm install

# Étape 3 : Image finale
FROM node:18
WORKDIR /app
COPY --from=api-build /app/api ./
COPY --from=api-build /app/api/node_modules ./node_modules
COPY --from=api-build /app/public ./public

ENV PORT=10000
EXPOSE 10000
CMD ["node", "index.js"]
