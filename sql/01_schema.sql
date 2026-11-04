-- Billing tables for the practice project. All data is made up.
create table plans (
  id text primary key,                      -- 'free', 'pro', 'team'
  monthly_price numeric(10,2) not null,
  included_storage_gb numeric not null,
  overage_per_gb numeric(10,3) not null
);

create table customers (
  id int primary key,
  name text not null,
  email text not null unique,
  country text not null
);

create table subscriptions (
  id int primary key,
  customer_id int not null references customers(id),
  plan_id text not null references plans(id),
  status text not null check (status in ('active', 'past_due', 'canceled')),
  started_at date not null,
  canceled_at date
);

create table invoices (
  id int primary key,
  customer_id int not null references customers(id),
  period_start date not null,
  period_end date not null,
  amount_due numeric(10,2) not null,
  status text not null check (status in ('open', 'paid', 'void')),
  due_date date not null
);

create table payments (
  id int primary key,
  invoice_id int not null references invoices(id),
  amount numeric(10,2) not null,
  status text not null check (status in ('succeeded', 'failed', 'refunded', 'disputed')),
  failure_reason text,
  attempted_at timestamptz not null
);

create table usage_records (
  id int generated always as identity primary key,
  customer_id int not null references customers(id),
  usage_month date not null,
  storage_gb numeric not null
);

-- Lock the tables so the public API can't read them. The SQL editor still can.
alter table plans enable row level security;
alter table customers enable row level security;
alter table subscriptions enable row level security;
alter table invoices enable row level security;
alter table payments enable row level security;
alter table usage_records enable row level security;
