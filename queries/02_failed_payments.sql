-- queries/02_failed_payments.sql
-- Every failed payment and why.
select c.email, i.id as invoice_id, p.amount, p.failure_reason, p.attempted_at
from payments p
join invoices i on i.id = p.invoice_id
join customers c on c.id = i.customer_id
where p.status = 'failed'
order by p.attempted_at desc;
