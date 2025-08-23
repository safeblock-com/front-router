FROM nginx:alpine

ARG FILE

WORKDIR /usr/share/nginx/html
RUN echo "This is content of file $FILE" > /usr/share/nginx/html/$FILE
COPY nginx.conf /etc/nginx/conf.d/default.conf
