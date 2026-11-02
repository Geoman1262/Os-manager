# OS Management

Cloudflare Worker + D1. All project files are placed directly in the repository root; no nested project folders are required.

## Deployment
1. Upload/extract all files directly into the GitHub repository root.
2. In Cloudflare Workers Builds, set Root directory to `/` and deploy command to `npx wrangler deploy`.
3. `wrangler.toml` is preconfigured with Worker name `os-manager` and the D1 database `os-management-db`.
4. The D1 schema is created automatically on the first app/API request. No separate migration command is required.

## Files
- `wrangler.toml`: Worker and D1 binding configuration.
- `worker.js`: Worker API and app delivery.
- `index.html`: app shell (Worker currently serves the embedded app shell).
- `app.js`: standalone copy of the browser app script.
- `0001_initial.sql`: reference schema; runtime initialization also creates these tables automatically.

The app uses USD as its base currency and stores the exchange rate on each order/expense. Protect the deployed app with Cloudflare Access before entering real customer information.
