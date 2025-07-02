# Etapa 1: Build de Angular
FROM node:22-alpine as builder

# nos movemos a la carpeta app
WORKDIR /app

# copiamos el package*.json a /app
COPY package*.json ./

# instalar dependencias
RUN npm install

# copiamos todo a la carpeta /app
COPY . .

# Construir la aplicación en modo producción
RUN npx ng build

# Etapa 2: Servir la aplicación con NGINX
FROM nginx:alpine

# Copiar los archivos del build al contenedor de NGINX
COPY --from=builder /app/dist/app-auto/browser /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]