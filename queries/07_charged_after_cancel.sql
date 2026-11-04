-- queries/07_charged_after_cancel.sql
-- Payments attempted after the subscription was canceled.
select c.email, s.canceled_at, i.id as invoice_id, p.amount, p.status as payment_status, p.attempted_at
from subscriptions s
join customers c on c.id = s.customer_id
join invoices i on i.customer_id = c.id
join payments p on p.invoice_id = i.id
where s.status = 'canceled'
  and p.attempted_at::date > s.canceled_at;
