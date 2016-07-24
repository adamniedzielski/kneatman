defmodule Kneatman.DifferenceDocument do
  defstruct invoice_number: nil, issue_date: nil, issue_amount_in_cents: nil,
    issue_rate: nil, issue_currency: nil, issue_rate_date: nil,
    converted_issue_amount_in_cents: nil, payment_date: nil, was_paid_in_pln: nil,
    payment_rate: nil, payment_rate_date: nil, converted_payment_amount_in_cents: nil,
    difference_in_cents: nil
end
