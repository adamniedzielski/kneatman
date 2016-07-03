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

  def generate_document do
  end
end
