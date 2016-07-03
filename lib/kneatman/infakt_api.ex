defmodule Kneatman.InFaktAPI do
  @callback find_invoice(api_key :: String.t, invoice_id :: String.t)
    :: %Kneatman.InFaktAPI.Invoice{}
end
