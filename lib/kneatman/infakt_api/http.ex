alias Kneatman.InFaktAPI.Invoice

defmodule Kneatman.InFaktAPI.HTTP do
  @behaviour Kneatman.InFaktAPI
  @api_url "https://api.infakt.pl/v3/invoices"

  def find_invoice(api_key, invoice_id) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.get("#{@api_url}/#{invoice_id}.json", [], params: %{api_key: api_key})
    payload = Poison.decode!(body)
    %Invoice{
      number: Map.fetch!(payload, "number"),
      amount_in_cents: Map.fetch!(payload, "gross_price"),
      currency: Map.fetch!(payload, "currency"),
      issue_date: payload |> Map.fetch!("invoice_date") |> Date.from_iso8601!
    }
  end
end
