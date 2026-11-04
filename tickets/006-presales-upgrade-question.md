# Ticket 006 (optional): What would upgrading cost?
Customer: grace@example.com | Channel: chat | Priority: low

## What the customer said
"I'm on the free plan and I'm at 0.9 GB. What happens if I go over 1 GB, and how much is Pro?"

## What I checked
The plans table and Grace's usage record (0.9 GB in October 2026).

```sql
select id, monthly_price, included_storage_gb, overage_per_gb from plans order by monthly_price;
```

## What I found
- Free: $0.00, 1 GB included, no overage rate. Grace has used 0.9 GB, so she has 0.1 GB left.
- Pro: $25.00 a month, 8 GB included, $0.125 per extra GB.
- Team: $100.00 a month, 50 GB included, $0.10 per extra GB.

## Reply to the customer
Hi Grace,

Thanks for asking. The Free plan includes 1 GB of storage and you're at 0.9 GB, so you're close to
the limit. Pro is $25.00 a month and includes 8 GB, with extra storage charged at $0.125 per GB.
If you're likely to pass 1 GB soon, Pro is the plan to look at. You can upgrade any time from the
Billing page.

Best,
John

## Internal note or escalation
No escalation. I haven't stated what happens at the Free limit, because the plans table doesn't
say; check the product documentation before promising anything specific.

## How to stop this happening again
Show Free users how much storage they have left and what the next plan costs, in the dashboard.
