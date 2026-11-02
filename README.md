# OS Management

Cloudflare Workers + D1 web application for Online Shopping.

## Upload to GitHub
Extract this ZIP and upload the CONTENTS to the root of your new GitHub repository (not the ZIP itself).

## Cloudflare setup
1. Create a D1 database named `os-management-db` in Cloudflare.
2. Copy its database ID into `wrangler.toml`, replacing `PASTE_YOUR_D1_DATABASE_ID_HERE`.
3. Install Wrangler: `npm install -g wrangler`
4. Login: `wrangler login`
5. Initialize database: `wrangler d1 execute os-management-db --remote --file=./migrations/0001_initial.sql`
6. Deploy: `wrangler deploy`

## Included features
Dashboard without charts; customers (no delete); orders with multiple items and independent USD/LBP sale and purchase currencies; saved FX per order/expense; separate delivery/customer payment/supplier payment flags; expense records; purchase summary; undelivered orders list/report; customer invoice print-to-PDF.

## Important limitations before real use
- No login is included, as requested. Protect the site with Cloudflare Access before entering real customer data.
- This is the first deployable foundation, not a fully audited production accounting system. Test with dummy records first.
- PDF uses the browser print dialog and Save as PDF.
- Full English UI, full financial date-range reports, expense editing, and payment-history/audit trail are not yet implemented.
- Payment flags are paid/unpaid only. Editing a paid order leaves its status as paid; deleting a paid order is irreversible. Confirm the accounting rules before using real transactions.
