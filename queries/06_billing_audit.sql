-- queries/06_billing_audit.sql
-- Billing audit: every invoice whose amount differs from plan price + storage overage.
select c.email, i.id as invoice_id, i.amount_due,
       pl.monthly_price + greatest(u.storage_gb - pl.included_storage_gb, 0) * pl.overage_per_gb as expected_total,
       i.amount_due - (pl.monthly_price + greatest(u.storage_gb - pl.included_storage_gb, 0) * pl.overage_per_gb) as difference
from invoices i
join customers c on c.id = i.customer_id
join subscriptions s on s.customer_id = c.id
join plans pl on pl.id = s.plan_id
join usage_records u on u.customer_id = c.id and u.usage_month = i.period_start
where i.amount_due <> pl.monthly_price + greatest(u.storage_gb - pl.included_storage_gb, 0) * pl.overage_per_gb;
