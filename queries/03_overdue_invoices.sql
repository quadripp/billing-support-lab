-- queries/03_overdue_invoices.sql
-- Unpaid invoices past their due date.
select c.email, i.id as invoice_id, i.amount_due, i.due_date,
       current_date - i.due_date as days_overdue
from invoices i
join customers c on c.id = i.customer_id
where i.status = 'open' and i.due_date < current_date
order by days_overdue desc;
