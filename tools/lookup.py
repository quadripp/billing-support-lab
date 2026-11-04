"""Print one customer's invoices and payment attempts from Supabase."""
import os
import sys

from dotenv import load_dotenv
from supabase import create_client

load_dotenv()
client = create_client(os.environ["SUPABASE_URL"], os.environ["SUPABASE_SECRET_KEY"])

email = sys.argv[1] if len(sys.argv) > 1 else input("Customer email: ").strip()
rows = client.rpc("billing_summary", {"customer_email": email}).execute().data

if not rows:
    print(f"No invoices found for {email}")
    sys.exit(0)

print(f"Billing summary for {email}\n")
for r in rows:
    line = f"Invoice {r['invoice_id']} ({r['period_start']}): ${float(r['amount_due']):.2f} [{r['invoice_status']}]"
    if r["payment_id"]:
        line += f"  payment {r['payment_id']}: ${float(r['amount']):.2f} {r['payment_status']}"
        if r["failure_reason"]:
            line += f" ({r['failure_reason']})"
    print(line)
