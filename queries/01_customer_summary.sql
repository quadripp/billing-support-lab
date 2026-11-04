-- queries/01_customer_summary.sql
-- First query on any billing ticket: everything about one customer. Change the email to look up anyone.
select c.name, c.email, s.plan_id, s.status as subscription_status,
       i.id as invoice_id, i.amount_due, i.status as invoice_status, i.due_date,
       p.id as payment_id, p.amount, p.status as payment_status, p.failure_reason, p.attempted_at
from customers c
join subscriptions s on s.customer_id = c.id
left join invoices i on i.customer_id = c.id
left join payments p on p.invoice_id = i.id
where c.email = 'ben@example.com'
order by i.period_start desc, p.attempted_at;
