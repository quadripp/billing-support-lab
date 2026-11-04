# Ticket 004: Bill higher than the plan price
Customer: emeka@example.com | Channel: chat | Priority: normal

## What the customer said
"My plan is $25 but you charged me $26.50. Why?"

## What I checked
queries/05_explain_invoice.sql with Emeka's email, then queries/06_billing_audit.sql to confirm
his invoice isn't flagged as wrong.

## What I found
- Plan: Pro, $25.00 a month, 8 GB storage included, $0.125 per extra GB
- October usage: 20 GB, so 12 GB over the allowance
- Overage: 12 GB x $0.125 = $1.50
- Expected total: $25.00 + $1.50 = $26.50, which matches invoice 105 exactly

The audit query does not list Emeka, so the invoice is correct. No refund is due.

## Reply to the customer
Hi Emeka,

Thanks for asking. Your Pro plan is $25.00 a month and includes 8 GB of storage. In October you
used 20 GB, which is 12 GB over the included amount. Extra storage is charged at $0.125 per GB,
so 12 x $0.125 = $1.50, and $25.00 + $1.50 = $26.50. That's the amount on your invoice.

To avoid the extra charge you can bring storage back under 8 GB, or move to the Team plan, which
includes 50 GB (though at $100.00 a month it would cost more than your current bill). You can
watch your usage on the Usage page in your dashboard.

Best,
John

## Internal note or escalation
No escalation. Invoice is correct. Possible product feedback: show a warning in the dashboard when
a customer is about to exceed the included storage, so the overage isn't a surprise.

## How to stop this happening again
Email customers when they reach about 80% of included storage, and show the projected overage on
the invoice preview.
