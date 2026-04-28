# Frontend Dockerfile - Nginx with Chess App
FROM nginx:alpine

# Update packages and install dependencies
RUN apk add --no-cache \
    curl \
    wget

# Create app directory
WORKDIR /app

# Copy built frontend files to Nginx
COPY build/ /usr/share/nginx/html/

# Copy nginx configuration
COPY ../nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Expose port
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
