FROM nginx:alpine
COPY ./public /usr/share/nginx/html/
COPY ./templates /etc/nginx/templates/
ARG NGINX_PORT=8000
ARG NGINX_RESOLVER=8.8.8.8

ENV NGINX_PORT=${NGINX_PORT}
ENV NGINX_RESOLVER=${NGINX_RESOLVER}
