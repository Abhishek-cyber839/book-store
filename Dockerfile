# FROM node:16-alpine AS build
# ARG CONFIGURATION='dev'
# we can use it as variable $CONFUGRATION
# WORKDIR /app
# COPY . .
# RUN npm install --legacy-peer-deps
# RUN npm run build --prod  --output-path=dist/book-store  --output-hashing=all

# Runtime
# FROM nginx:stable-alpine
# Remove default nginx website
# RUN rm -rf /usr/share/nginx/html/*
# Copy nginx config file
# COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
# Copy dist folder fro build stage to nginx public folder
# COPY --from=build /app/dist/book-store /usr/share/nginx/html
# Start NgInx service
# CMD ["nginx", "-g", "daemon off;"]

#stage 1
FROM node:latest as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod
#stage 2
FROM nginx:alpine
COPY --from=node /app/dist/book-store /usr/share/nginx/html