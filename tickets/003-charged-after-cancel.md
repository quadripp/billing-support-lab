# Ticket 003: Charged after canceling
Customer: dana@example.com | Channel: email | Priority: normal

## What the customer said
"I canceled in early October, so why did you take $25 on 1 November?"

## What I checked
queries/07_charged_after_cancel.sql, then queries/01_customer_summary.sql with Dana's email.

## What I found
- Subscription 4 (Pro) was canceled on 3 October 2026.
- Invoice 104 covers 1 to 31 October, $25.00. Her cancellation fell inside that period, so an
  invoice for October is expected.
- Payment 1006 for $25.00 was attempted on 1 November 2026, 29 days after she canceled, and its
  status is now refunded.

So the refund has already been issued. The open question is why a charge was attempted after
cancellation. Note that the 1 November attempt was for the October invoice, so it may be a
legitimate final bill that should not have been collected, or a collection that ignored the
cancellation. Billing needs to confirm which.

## Reply to the customer
Hi Dana,

Thanks for writing, and I'm sorry about the charge. I can see you canceled your Pro plan on
3 October, and a payment of $25.00 was taken on 1 November. That payment has already been
refunded to your original payment method. Refunds typically appear within 5 to 10 business days,
depending on your bank.

You won't be billed again, as your subscription is canceled. If the refund hasn't appeared after
10 business days, reply here and I'll chase it with our billing team.

Best,
John

## Internal note or escalation
To: billing engineering, as a possible bug. A payment was attempted on a canceled subscription.
- Customer: dana@example.com, subscription 4, canceled 2026-10-03
- Invoice 104 ($25.00), payment 1006, attempted 2026-11-01, now refunded
- Query 07 returns only this one row, so it is isolated so far
- Please confirm whether canceled subscriptions are excluded from the collection job, and whether
  the final invoice after a cancellation should be charged at all.

## How to stop this happening again
Exclude canceled subscriptions from the payment collection job, or decide and document the policy
for a final prorated invoice. Run query 07 weekly to catch any recurrence.
