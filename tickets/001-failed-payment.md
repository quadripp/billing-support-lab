# Ticket 001: Payment failed, invoice overdue
Customer: ben@example.com | Channel: email | Priority: high

## What the customer said
"I got an email saying my payment failed, but I have money in my account. What's going on?"

## What I checked
queries/01_customer_summary.sql with Ben's email, then queries/03_overdue_invoices.sql.

## What I found
The October invoice (102, $25.00) was due on 1 November. Two charges failed: card_declined on
1 November and insufficient_funds on 3 November. The subscription is past_due.

## Reply to the customer
Hi Ben,

Thanks for getting in touch, and sorry for the trouble. I checked your account: we tried to
charge your card for your October invoice ($25.00) twice. On 1 November your bank declined the
card, and on 3 November the payment failed because of insufficient funds. That's why the invoice
is still open and your account shows as past due.

To fix it, please update your card or check the balance on it, then retry the payment from the
Billing page. If you need a few more days to pay, reply here and I'll ask our billing team about
an extension.

Best,
John

## Internal note or escalation
No escalation yet. If Ben asks for an extension, send it to the billing team with invoice 102
and both failure reasons.

## How to stop this happening again
Send a reminder a few days before the due date, and add a help article on what each failure
reason means.
