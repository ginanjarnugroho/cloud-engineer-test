# Gunakan image node untuk build
FROM node:18-alpine AS build

WORKDIR /app
COPY . .

RUN npm install
RUN npm run build

# Gunakan image nginx untuk serve hasil build
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Salin konfigurasi nginx default (opsional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
