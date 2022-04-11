FROM nginx:1.14.2-alpine

COPY ./frontend/public/index.html /usr/share/nginx/html/
