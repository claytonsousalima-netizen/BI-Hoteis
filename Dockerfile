# ============================================================
# Dockerfile — BI Hotéis
#
# Build static site served by Nginx
# Target: linux/arm64 (AWS t4g.medium)
# ============================================================

FROM nginx:1.27-alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy static files
COPY index.html /usr/share/nginx/html/
COPY loader.html /usr/share/nginx/html/
COPY BI_Hoteis_MarketShare.html /usr/share/nginx/html/

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget -qO- http://127.0.0.1/healthz || exit 1

# EXPOSE port 80 for HTTP traffic
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
