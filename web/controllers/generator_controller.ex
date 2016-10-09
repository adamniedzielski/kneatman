defmodule Kneatman.GeneratorController do
  @infakt_api Application.get_env(:kneatman, :infakt_api)
  use Kneatman.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def fetch_invoice_details(
    conn,
    %{"infakt" => %{"api_key" => api_key, "invoice_id" => invoice_id}}
  ) do
    invoice = @infakt_api.find_invoice(api_key, invoice_id)
    render conn, "fetch_invoice_details.html", invoice: invoice
  end

  def generate_document(conn, %{"invoice" => invoice_params}) do
    aaa = %{
      issue_amount_in_cents: invoice_params["issue_amount_in_cents"] |> String.to_integer,
      issue_currency: invoice_params["issue_currency"],
      issue_date: invoice_params["issue_date"] |> Date.from_iso8601!,
      number: invoice_params["number"],
      payment_currency: invoice_params["payment_currency"],
      payment_date: invoice_params["payment_date"] |> Date.from_iso8601!
    }
    document = Kneatman.GenerateDifferenceDocument.call(aaa)
    render conn, "generate_document.html", document: document
  end
end
