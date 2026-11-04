# Billing Support Lab (Supabase)

A practice project for billing support work: a small billing database in Supabase (Postgres),
SQL queries that investigate common billing problems, and five support tickets worked from first
message to reply (plus an optional pre-sales sixth). All data is made up.

## What's inside
| Folder | Contents |
| --- | --- |
| sql/ | Tables, test data and a lookup function |
| queries/ | Seven SQL queries for billing investigations |
| tickets/ | Support tickets with investigation, reply and escalation note |
| tools/ | Python script that prints a customer's billing history |

## Scenarios
| Customer | Problem | Found with |
| --- | --- | --- |
| Ben | Two failed payments, invoice overdue | queries 01, 02, 03 |
| Chen | Charged twice | query 04 |
| Dana | Charged after canceling, refunded | query 07 |
| Emeka | Bill higher than plan price | query 05 |
| Fatima | Overbilled by $10, disputed the charge | query 06 |
| Grace | Pre-sales: what would Pro cost? | plans table |

## How to run it
1. Create a free Supabase project.
2. In the SQL Editor, run sql/01_schema.sql, sql/02_seed.sql and sql/03_billing_summary_function.sql.
3. Run any file in queries/.
4. Optional: copy .env.example to .env, add your project URL and secret key,
   run pip install supabase python-dotenv, then python tools/lookup.py ben@example.com

The `.env` file is git-ignored. Never commit a real key.

## Verification
Every SQL file and every expected result in the tickets was run against PostgreSQL 16 (the
database Supabase runs on). The `service_role` grants in step 3 need Supabase's built-in roles, so
the function file was checked with those roles created locally. See `docs/verification.md`.

## Skills shown
SQL, Postgres, Supabase, row level security, billing investigation, customer communication,
escalation writing, Python.
