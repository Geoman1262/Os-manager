# OS Management

Cloudflare Worker + D1. All project files are at the repository root; there are no source, public, or migrations subfolders.

## Fix for the previous deploy error

The Worker entry point is now `worker.js` in the repository root, and `wrangler.toml` uses `main = "worker.js"`. This removes the previous `src/worker.js not found` error. The Worker serves the embedded web interface and app script itself, so no assets directory is required.

## Cloudflare setup

1. Create a D1 database named `os-management-db` in Cloudflare.
2. Copy its database ID into `wrangler.toml`, replacing `PASTE_YOUR_D1_DATABASE_ID_HERE`. This is required; deployment will not complete with the placeholder.
3. Run the SQL migration against the D1 database: `npx wrangler d1 execute os-management-db --remote --file=0001_initial.sql`.
4. Deploy from the repository root with `npx wrangler deploy`.

For Cloudflare Workers Builds, set the root directory to `/` (repository root) and deploy command to `npx wrangler deploy`.

## Important

This is an initial working foundation, not a fully audited production accounting system. Configure the D1 database before using it with real business data.
