# ––– Multistage build fra Docker Docs ––– #
# ––– Build Stadiet ––– #
# -- der bliver brugt Node fordi det er det vores Projekt er bygget op med
FROM node:24-alpine AS build
LABEL authors="katja"
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
# ––– Runtime Stadiet ––– #
# Køre resultat helt nyt og rent
FROM node:24-alpine AS runtime
# -- Miljøvariabel
ENV NODE_ENV=production
# -- Hvor henne?
WORKDIR /app
# -- Der bliver kopieret fra build
COPY --from=build
# -- Kør projektet
RUN npm i
COPY --from=build /app/dist ./dist
# -- der bliver tilføjet USER da Node-imaget har allerede indbygget bruger
# den operettede bruger er ikke root
USER user
# -- Port
EXPOSE 3000
# -- Kommandoer
CMD ["node", "dist/main.ts"]
ENTRYPOINT ["top", "-b"]