# Use official lightweight Nginx Alpine distribution
FROM nginx:alpine

# Remove default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy local application file into Nginx serving directory
COPY index.html /usr/share/nginx/html/index.html

# Expose internal HTTP port
EXPOSE 80

# Run Nginx in foreground mode
CMD ["nginx", "-g", "daemon off;"]
