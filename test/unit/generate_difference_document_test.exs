defmodule Kneatman.GenerateDifferenceDocumentTest do
  use ExUnit.Case, async: true

  test "payment in the currency issued" do
    result = Kneatman.GenerateDifferenceDocument.call(
      %{
        number: "03/05/2016",
        issue_amount_in_cents: 12456,
        issue_currency: "EUR",
        issue_date: ~D[2016-05-31],
        payment_date: ~D[2016-06-05],
        payment_currency: "EUR"
      }
    )

    assert result == %Kneatman.DifferenceDocument{
      invoice_number: "03/05/2016",
      issue_date: ~D[2016-05-31],
      issue_amount_in_cents: 12456,
      issue_rate: Decimal.new(4.3945),
      issue_currency: "EUR",
      issue_rate_date: ~D[2016-05-30],
      converted_issue_amount_in_cents: 54738,
      payment_date: ~D[2016-06-05],
      was_paid_in_pln: false,
      payment_rate: Decimal.new(4.3913),
      payment_rate_date: ~D[2016-06-03],
      converted_payment_amount_in_cents: 54698,
      difference_in_cents: -40
    }
  end

  test "payment in PLN" do
    result = Kneatman.GenerateDifferenceDocument.call(
      %{
        number: "04/06/2016",
        issue_amount_in_cents: 21342,
        issue_currency: "USD",
        issue_date: ~D[2016-06-30],
        payment_date: ~D[2016-07-07],
        payment_currency: "PLN",
        payment_amount_in_pln: 83874
      }
    )

    assert result == %Kneatman.DifferenceDocument{
      invoice_number: "04/06/2016",
      issue_date: ~D[2016-06-30],
      issue_amount_in_cents: 21342,
      issue_rate: Decimal.new(3.9905),
      issue_currency: "USD",
      issue_rate_date: ~D[2016-06-29],
      converted_issue_amount_in_cents: 85165,
      payment_date: ~D[2016-07-07],
      was_paid_in_pln: true,
      converted_payment_amount_in_cents: 83874,
      difference_in_cents: -1291
    }
  end
end
