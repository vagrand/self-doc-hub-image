FROM alpine:3.20
RUN apk add --no-cache ca-certificates wget \
    && addgroup -S docs-hub && adduser -S docs-hub -G docs-hub \
    && mkdir -p /data && chown docs-hub:docs-hub /data
COPY --chmod=0755 docs-hub /usr/local/bin/docs-hub
COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY translations /opt/docs-hub/translations

ENV DOCS_HUB_DATA_DIR=/data \
    DOCS_HUB_ADDR=:8080
VOLUME ["/data"]
EXPOSE 8080
USER docs-hub

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget -q --spider http://127.0.0.1:8080/healthz || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
