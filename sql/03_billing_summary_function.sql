-- One customer's invoices and payment attempts, newest first.
create or replace function billing_summary(customer_email text)
returns table (
  invoice_id int,
  period_start date,
  amount_due numeric,
  invoice_status text,
  payment_id int,
  amount numeric,
  payment_status text,
  failure_reason text,
  attempted_at timestamptz
)
language sql
stable
set search_path = public
as $$
  select i.id, i.period_start, i.amount_due, i.status,
         p.id, p.amount, p.status, p.failure_reason, p.attempted_at
  from customers c
  join invoices i on i.customer_id = c.id
  left join payments p on p.invoice_id = i.id
  where c.email = customer_email
  order by i.period_start desc, p.attempted_at;
$$;

-- Only the secret (service role) key may call it, not the public API keys.
revoke execute on function billing_summary(text) from public, anon, authenticated;
grant execute on function billing_summary(text) to service_role;
