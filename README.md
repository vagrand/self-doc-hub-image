# SelfDocHub — Docker image

[SelfDocHub](https://selfdochub.com) is a self-hosted portal for your API documentation. It collects OpenAPI, AsyncAPI, OpenRPC and GraphQL specifications from many services in one place and keeps their version history.

Main features:

- Multiple specification formats, services and groups, versions and branches, merge rules
- Automatic Change Log between versions
- Search and navigation across all services
- Try-It console, saved requests and environments
- Markdown overlays and text pages, export to PDF with cover pages
- Roles, teams, two-factor authentication and single sign-on (SSO)
- MCP server for AI assistants
- Notifications and audit log
- Single static binary, SQLite storage, no external database

This repository contains the prebuilt `docs-hub` binary and Docker settings to run it on your host.

## Quick start

```bash
git clone https://github.com/vagrand/self-doc-hub-image.git
cd self-doc-hub-image

cp .env.example .env
# edit .env: set DOCS_HUB_BASE_URL and DOCS_HUB_SESSION_SECRET (openssl rand -base64 32)

docker compose up -d --build
docker compose logs -f docs-hub
```

The application listens on `127.0.0.1:8080`. Put a reverse proxy with TLS (Nginx, Caddy) in front of it, and set `client_max_body_size` to at least 12m.

## First run

```bash
# create the first administrator
docker compose exec docs-hub docs-hub --create-user \
  --user-login admin --user-password 'change-me' --user-role admin

# print the device ID to request a license
docker compose exec docs-hub docs-hub --print-device-id
```

Upload the resulting `license.json` on the License page. Check health: `curl http://127.0.0.1:8080/healthz`.

## Data and upgrades

All state lives in the `docs-hub-data` Docker volume (mounted at `/data`). Run exactly one container per volume.

- Back up the volume and your `.env` file (the session secret is needed to decrypt stored secrets).
- Upgrade: `git pull && docker compose up -d --build`. Migrations run automatically.

Other settings are optional; see the [configuration reference](https://selfdochub.com/documentation/configuration).

## Documentation

Full documentation: <https://selfdochub.com>
