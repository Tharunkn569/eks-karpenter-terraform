# Stage 1: Build static application content
FROM alpine:3.20 AS builder

WORKDIR /app

COPY index.html .

RUN mkdir -p /build \
    && cp index.html /build/index.html


# Stage 2: Runtime image
FROM nginx:1.25-alpine

LABEL app="orders-microservice"
LABEL maintainer="Tharun"
LABEL environment="demo"

RUN rm -rf /usr/share/nginx/html/*

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /build/index.html /usr/share/nginx/html/index.html

RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /usr/share/nginx/html \
    && chown -R appuser:appgroup /var/cache/nginx \
    && chown -R appuser:appgroup /var/log/nginx \
    && chown -R appuser:appgroup /etc/nginx/conf.d \
    && touch /var/run/nginx.pid \
    && chown -R appuser:appgroup /var/run/nginx.pid

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/health || exit 1

CMD ["nginx", "-g", "daemon off;"]