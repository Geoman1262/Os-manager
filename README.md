# OS Management — item-level accounting update

## Important deployment notes
- This package preserves the existing Cloudflare Worker + D1 structure and existing app sections.
- `worker.js` serves the embedded `index.html` and `app.js`; the separate copies are included for convenience/reference.
- D1 changes are additive: the Worker creates `customer_item_payments` and adds `received` / `delivered` columns to `order_items` on first API request.
- A one-time compatibility migration maps legacy order-level supplier/delivery flags to item states and converts legacy fully-paid order flags into item-level payment rows. Existing order/customer/expense records are not deleted.
- Do not run `0002_item_level_accounting.sql` manually if the Worker has already auto-migrated; the Worker performs guarded column checks.

## Deploy
1. Keep a backup of the current repository and D1 database before replacing files.
2. Upload all files at the repository root (no nested folder).
3. Keep the existing `wrangler.toml` and D1 database binding unchanged.
4. Deploy using the same Cloudflare Worker build/deploy process already used by the project.
5. Test with a new test customer and test invoice before relying on live workflows.

## Accounting rules implemented
- Item status: `عند التاجر` → `مستلم ومدفوع` → `تم تسليمه للزبون`.
- Delivery cannot be recorded before receipt; receipt and delivery cannot be toggled backwards.
- Receipt records supplier cost as paid internally (no trader interface).
- Customer payments are separate dated transactions linked to one item; date is set automatically.
- Payment cannot exceed that item's remaining sale balance; payment can be recorded before supplier receipt.
- Payments can be deleted only from the invoice detail view, after confirmation; balances are recalculated.
- Invoice items are immutable after creation. Invoice deletion is allowed only if no item was received and no customer payment exists.
- Dashboard lists invoices until both all items are delivered and the customer balance is zero.
- Invoice detail shows sales, purchase cost, profit, customer paid, and customer due.

## Security
Protect the Worker with Cloudflare Access before storing real customer data.
