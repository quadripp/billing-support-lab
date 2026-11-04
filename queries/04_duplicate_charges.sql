-- queries/04_duplicate_charges.sql
-- Invoices with more than one successful payment (customers charged twice).
select i.id as invoice_id, c.email, i.amount_due,
       count(*) as successful_payments, sum(p.amount) as total_charged
from payments p
join invoices i on i.id = p.invoice_id
join customers c on c.id = i.customer_id
where p.status = 'succeeded'
group by i.id, c.email, i.amount_due
having count(*) > 1;
