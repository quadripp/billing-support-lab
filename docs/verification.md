# Verification

## What was tested
Run on **PostgreSQL 16.15** (local, Homebrew), 4 November 2026:

| Check | Result |
| --- | --- |
| `sql/01_schema.sql`, `02_seed.sql`, `03_billing_summary_function.sql` run without error | Pass |
| `select count(*) from payments` | 8 |
| Query 01 (Ben) | 2 failed attempts on invoice 102: card_declined, insufficient_funds |
| Query 02 | Ben's two attempts only |
| Query 03 | Invoice 102 only (days overdue counts up from 1 Nov; 3 when run on 4 Nov) |
| Query 04 | Invoice 103 (Chen): 2 successful payments, $200 on a $100 invoice |
| Query 05 (Emeka) | 20 GB used, 12 GB over, overage $1.50, expected $26.50 = invoiced $26.50 |
| Query 06 | Invoice 106 (Fatima): invoiced $110, expected $100, difference $10; no other row |
| Query 07 | Dana: $25 refunded payment on 1 Nov, canceled 3 Oct; no other row |
| Row level security enabled on all six tables | Pass |
| `billing_summary('ben@example.com')` as `service_role` | Returns Ben's two failed payments |
| Same function as `anon` | `permission denied for function billing_summary` |
| Reading `invoices` as `anon` | 0 rows |

To mimic Supabase locally, the roles `anon`, `authenticated` and `service_role` (with
`bypassrls` on `service_role`) were created and given the default table grants Supabase applies.

## What was not tested
- **A live Supabase project.** The SQL was run on plain Postgres 16, not through the Supabase
  dashboard.
- **`tools/lookup.py`.** It needs a real Supabase URL and secret key, so it has not been run. Its
  expected output for `ben@example.com` is:

```text
Billing summary for ben@example.com

Invoice 102 (2026-10-01): $25.00 [open]  payment 1002: $25.00 failed (card_declined)
Invoice 102 (2026-10-01): $25.00 [open]  payment 1003: $25.00 failed (insufficient_funds)
```
