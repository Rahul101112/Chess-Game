# Frontend Docker Image
FROM nginx:alpine

# Copy built frontend to nginx
COPY build/ /usr/share/nginx/html/

# Copy nginx configuration
COPY ../nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
