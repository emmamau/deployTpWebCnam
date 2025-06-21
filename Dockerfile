# Étape 1 : Build Angular app
FROM node:20 AS builder


WORKDIR /app

COPY client ./client
WORKDIR /app/client

RUN echo "Démarrage du build Angular...2"
RUN npm install
RUN npm run ng build  --verbose 

RUN mkdir /build


RUN ls -R /app



# Étape 2 : Préparer le backend Node.js
FROM node:20 AS api-build
WORKDIR /app
COPY api ./api
WORKDIR /app/api
RUN npm install

# Étape 3 : Image finale
FROM node:20
WORKDIR /app
COPY --from=builder /app/dist/* /app/public/
COPY --from=api-build /app/api ./
COPY --from=api-build /app/api/node_modules ./node_modules

ENV PORT=10000
EXPOSE 10000
CMD ["node", "index.js"]
