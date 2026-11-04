-- Prices are invented for practice; they are not Supabase's real prices.
insert into plans (id, monthly_price, included_storage_gb, overage_per_gb) values
  ('free', 0, 1, 0),
  ('pro', 25, 8, 0.125),
  ('team', 100, 50, 0.100);

insert into customers (id, name, email, country) values
  (1, 'Ada Okafor',   'ada@example.com',    'Nigeria'),
  (2, 'Ben Carter',   'ben@example.com',    'United Kingdom'),
  (3, 'Chen Wei',     'chen@example.com',   'Singapore'),
  (4, 'Dana Silva',   'dana@example.com',   'Portugal'),
  (5, 'Emeka Nwosu',  'emeka@example.com',  'Nigeria'),
  (6, 'Fatima Bello', 'fatima@example.com', 'Ghana'),
  (7, 'Grace Lee',    'grace@example.com',  'Canada');

insert into subscriptions (id, customer_id, plan_id, status, started_at, canceled_at) values
  (1, 1, 'pro',  'active',   '2026-03-01', null),
  (2, 2, 'pro',  'past_due', '2026-05-01', null),
  (3, 3, 'team', 'active',   '2026-01-01', null),
  (4, 4, 'pro',  'canceled', '2026-06-01', '2026-10-03'),
  (5, 5, 'pro',  'active',   '2026-02-01', null),
  (6, 6, 'team', 'active',   '2026-04-01', null),
  (7, 7, 'free', 'active',   '2026-10-15', null);

-- October 2026 invoices, all due 1 November 2026
insert into invoices (id, customer_id, period_start, period_end, amount_due, status, due_date) values
  (101, 1, '2026-10-01', '2026-10-31',  25.00, 'paid', '2026-11-01'),
  (102, 2, '2026-10-01', '2026-10-31',  25.00, 'open', '2026-11-01'),
  (103, 3, '2026-10-01', '2026-10-31', 100.00, 'paid', '2026-11-01'),
  (104, 4, '2026-10-01', '2026-10-31',  25.00, 'paid', '2026-11-01'),
  (105, 5, '2026-10-01', '2026-10-31',  26.50, 'paid', '2026-11-01'),
  (106, 6, '2026-10-01', '2026-10-31', 110.00, 'paid', '2026-11-01');

insert into payments (id, invoice_id, amount, status, failure_reason, attempted_at) values
  (1001, 101,  25.00, 'succeeded', null,                 '2026-11-01 09:00+00'),
  (1002, 102,  25.00, 'failed',    'card_declined',      '2026-11-01 09:00+00'),
  (1003, 102,  25.00, 'failed',    'insufficient_funds', '2026-11-03 09:00+00'),
  (1004, 103, 100.00, 'succeeded', null,                 '2026-11-01 09:00+00'),
  (1005, 103, 100.00, 'succeeded', null,                 '2026-11-01 09:02+00'),
  (1006, 104,  25.00, 'refunded',  null,                 '2026-11-01 09:00+00'),
  (1007, 105,  26.50, 'succeeded', null,                 '2026-11-01 09:00+00'),
  (1008, 106, 110.00, 'disputed',  null,                 '2026-11-01 09:00+00');

insert into usage_records (customer_id, usage_month, storage_gb) values
  (1, '2026-10-01',  3.2),
  (2, '2026-10-01',  5.0),
  (3, '2026-10-01', 41.0),
  (4, '2026-10-01',  0.4),
  (5, '2026-10-01', 20.0),
  (6, '2026-10-01', 12.5),
  (7, '2026-10-01',  0.9);
