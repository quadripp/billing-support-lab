# Ticket 002: Charged twice for the same invoice
Customer: chen@example.com | Channel: chat | Priority: high

## What the customer said
"I was charged $100 twice this month. Please fix this."

## What I checked
queries/04_duplicate_charges.sql, then queries/01_customer_summary.sql with Chen's email to see
the payment timestamps.

## What I found
Invoice 103 (October, $100.00, Team plan) has two successful payments:
- Payment 1004: $100.00, 1 November 2026 09:00 UTC
- Payment 1005: $100.00, 1 November 2026 09:02 UTC

Total charged $200.00 against a $100.00 invoice. The second payment came two minutes after the
first, which points to a retry or double submission rather than a second billing period. Chen's
other data is normal: 41 GB used against 50 GB included, so no overage applies.

## Reply to the customer
Hi Chen,

Thank you for flagging this, and I'm sorry. You're right: your October invoice was $100.00, but
two payments of $100.00 went through two minutes apart on 1 November. You should only have paid
once.

I've asked our billing team to refund the second payment ($100.00). Refunds usually reach your
card within 5 to 10 business days, depending on your bank. I'll update you here as soon as the
refund is confirmed.

Best,
John

## Internal note or escalation
To: billing team. Please refund $100.00 for the duplicate charge.
- Customer: chen@example.com, invoice 103 ($100.00, status paid)
- Payments: 1004 (keep) and 1005 (refund), both succeeded on 2026-11-01, two minutes apart
- No other customer has more than one successful payment on an invoice (query 04 returns only
  invoice 103)
- Please check why the charge ran twice (retry job or double submit) before the next cycle.

## How to stop this happening again
Make the charge request idempotent, so a retry for an invoice that already has a successful
payment is rejected. Add a daily check that runs query 04 and alerts on any result.
