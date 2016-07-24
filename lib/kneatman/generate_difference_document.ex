defmodule Kneatman.GenerateDifferenceDocument do
  def call(
    %{
      number: invoice_number,
      issue_amount_in_cents: issue_amount_in_cents,
      issue_currency: issue_currency,
      issue_date: issue_date,
      payment_date: payment_date,
      payment_currency: "PLN",
      payment_amount_in_pln: payment_amount_in_pln
    }
  ) do
    [rate: issue_rate, date: issue_rate_date] = issue_date
      |> Calendar.Date.prev_day!
      |> Graffinite.get_rate_with_date(issue_currency)

    converted_issue_amount_in_cents = issue_amount_in_cents |> Decimal.new |> Decimal.mult(issue_rate) |> Decimal.round |> Decimal.to_integer

    %Kneatman.DifferenceDocument{
      invoice_number: invoice_number,
      issue_date: issue_date,
      issue_amount_in_cents: issue_amount_in_cents,
      issue_rate: issue_rate,
      issue_currency: issue_currency,
      issue_rate_date: issue_rate_date,
      converted_issue_amount_in_cents: converted_issue_amount_in_cents,
      payment_date: payment_date,
      was_paid_in_pln: true,
      converted_payment_amount_in_cents: payment_amount_in_pln,
      difference_in_cents: payment_amount_in_pln - converted_issue_amount_in_cents
    }
  end

  def call(
    %{
      number: invoice_number,
      issue_amount_in_cents: issue_amount_in_cents,
      issue_currency: issue_currency,
      issue_date: issue_date,
      payment_date: payment_date,
      payment_currency: payment_currency
    }
  ) when payment_currency != "PLN" do
    [rate: issue_rate, date: issue_rate_date] = issue_date
      |> Calendar.Date.prev_day!
      |> Graffinite.get_rate_with_date(issue_currency)

    [rate: payment_rate, date: payment_rate_date] = payment_date
      |> Calendar.Date.prev_day!
      |> Graffinite.get_rate_with_date(issue_currency)

    converted_issue_amount_in_cents = issue_amount_in_cents |> Decimal.new |> Decimal.mult(issue_rate) |> Decimal.round |> Decimal.to_integer
    converted_payment_amount_in_cents = issue_amount_in_cents |> Decimal.new |> Decimal.mult(payment_rate) |> Decimal.round |> Decimal.to_integer

    %Kneatman.DifferenceDocument{
      invoice_number: invoice_number,
      issue_date: issue_date,
      issue_amount_in_cents: issue_amount_in_cents,
      issue_rate: issue_rate,
      issue_currency: issue_currency,
      issue_rate_date: issue_rate_date,
      converted_issue_amount_in_cents: converted_issue_amount_in_cents,
      payment_date: payment_date,
      was_paid_in_pln: false,
      payment_rate: payment_rate,
      payment_rate_date: payment_rate_date,
      converted_payment_amount_in_cents: converted_payment_amount_in_cents,
      difference_in_cents: converted_payment_amount_in_cents - converted_issue_amount_in_cents
    }
  end
end
