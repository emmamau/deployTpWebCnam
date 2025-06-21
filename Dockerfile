# Étape 1 : Build Angular app
FROM node:22.12.0 AS builder


WORKDIR /app

COPY frontCnam ./front
WORKDIR /app/front

RUN echo "Démarrage du build Angular"

RUN npm install -g npm
RUN npm install -g @angular/cli

RUN npm install
RUN ng build --configuration=production

RUN mkdir /build






# Étape 2 : Préparer le backend Node.js
FROM node:22.12.0 AS api-build
WORKDIR /app
COPY api ./api
WORKDIR /app/api
RUN npm install

# Étape 3 : Image finale
FROM node:22.12.0
WORKDIR /app
RUN mkdir /build
COPY --from=builder /app/front/dist/* /app
COPY --from=api-build /app/api ./api
COPY --from=api-build /app/api/node_modules ./api/node_modules

ENV PORT=10000
EXPOSE 10000
CMD ["node", "/api/index.js"]
