defmodule Kneatman.GeneratingDifferenceTest do
  use Kneatman.AcceptanceCase, async: true

  test "generates pdf", %{session: session} do
    session
    |> visit("/")
    |> fill_in("API key", with: "123456")
    |> fill_in("Invoice ID", with: "123")
    |> click_on("Fetch invoice")
    |> fill_in("Payment date", with: "2016-06-15")
    |> fill_in("Paid currency", with: "USD")
    |> click_on("Generate")

    text = session |> find("body") |> text

    assert String.contains?(
      text, 
      "Amount on the invoice 10.00 x 3.8545 (USD exchange rate for 2016-06-10)"
    )
  end
end
