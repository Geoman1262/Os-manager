-- Safe additive migration. Existing tables and records are retained.
ALTER TABLE order_items ADD COLUMN received INTEGER NOT NULL DEFAULT 0;
ALTER TABLE order_items ADD COLUMN delivered INTEGER NOT NULL DEFAULT 0;
CREATE TABLE IF NOT EXISTS customer_item_payments (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 item_id INTEGER NOT NULL REFERENCES order_items(id),
 amount REAL NOT NULL CHECK(amount > 0),
 date TEXT NOT NULL,
 created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
