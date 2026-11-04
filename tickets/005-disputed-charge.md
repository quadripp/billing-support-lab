# Ticket 005: Disputed charge, customer was overbilled
Customer: fatima@example.com | Channel: email | Priority: high

## What the customer said
"I've disputed your $110 charge with my bank. My plan is $100."

## What I checked
queries/06_billing_audit.sql, then queries/05_explain_invoice.sql with Fatima's email, then
queries/01_customer_summary.sql to see the payment status.

## What I found
- Plan: Team, $100.00 a month, 50 GB included, $0.10 per extra GB
- October usage: 12.5 GB, well inside the 50 GB allowance, so overage is $0.00
- Expected total: $100.00. Invoice 106 was issued for $110.00
- Difference: $10.00 overbilled
- Payment 1008 ($110.00, 1 November) has status disputed

Fatima is right. This is a real billing error, not a misunderstanding. The audit query returns
only her invoice, so no other invoice is affected.

## Reply to the customer
Hi Fatima,

Thank you for contacting us, and I'm sorry. I checked your account and you're right: your Team
plan is $100.00 a month and you used 12.5 GB of your 50 GB, so there was no extra storage charge.
Your October invoice should have been $100.00, but it was issued for $110.00, so you were
overcharged $10.00.

I've escalated this to our billing engineers so the $10.00 is corrected and the cause is found.
Because you've already opened a dispute with your bank, we'll respond to it with this
information so you don't need to do anything further on our side. I'll write again as soon as
the correction is confirmed.

Best,
John

## Internal note or escalation
To: billing engineering, cc billing team and disputes. Priority high.
- Customer: fatima@example.com, Team plan, invoice 106
- Invoiced: $110.00. Expected: $100.00 (plan $100.00 + overage $0.00, usage 12.5 GB of 50 GB)
- Difference: $10.00 overbilled
- Payment 1008, $110.00, 2026-11-01, status disputed (bank dispute opened by the customer)
- Scope: query 06 audits every invoice and returns only invoice 106, so no other invoice is
  affected
- Request: confirm the cause of the extra $10.00, issue the $10.00 correction, and supply our
  response to the bank dispute. Do not contest the dispute for the $10.00 overcharge.

## How to stop this happening again
Run the billing audit (query 06) before invoices are finalised each month and block any invoice
that doesn't match plan price plus overage. Investigate how $10.00 was added to this one.
