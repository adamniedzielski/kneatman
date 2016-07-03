defmodule Kneatman.FetchingInvoiceTest do
  use Kneatman.AcceptanceCase, async: true

  test "displays invoice details based on API response", %{session: session} do
    session
    |> visit("/")
    |> fill_in("API key", with: "123456")
    |> fill_in("Invoice ID", with: "123")
    |> click_on("Fetch invoice")

    text = session |> find("body") |> text

    assert String.contains?(text, "Invoice number 2/05/2016")
    assert String.contains?(text, "Amount 1000")
    assert String.contains?(text, "Invoice currency USD")
    assert String.contains?(text, "Issue date 2016-06-12")
  end
end
