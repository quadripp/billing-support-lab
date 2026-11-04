-- queries/05_explain_invoice.sql
-- Why a bill is higher than the plan price: plan price plus storage overage.
select c.email, pl.id as plan, pl.monthly_price,
       u.storage_gb, pl.included_storage_gb,
       greatest(u.storage_gb - pl.included_storage_gb, 0) as overage_gb,
       greatest(u.storage_gb - pl.included_storage_gb, 0) * pl.overage_per_gb as overage_cost,
       pl.monthly_price + greatest(u.storage_gb - pl.included_storage_gb, 0) * pl.overage_per_gb as expected_total,
       i.amount_due as invoiced
from customers c
join subscriptions s on s.customer_id = c.id
join plans pl on pl.id = s.plan_id
join invoices i on i.customer_id = c.id and i.period_start = '2026-10-01'
join usage_records u on u.customer_id = c.id and u.usage_month = i.period_start
where c.email = 'emeka@example.com';
