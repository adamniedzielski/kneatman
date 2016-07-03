alias Kneatman.InFaktAPI.Invoice

defmodule Kneatman.InFaktAPI.Mock do
  @behaviour Kneatman.InFaktAPI

  def find_invoice(_, _) do
    %Invoice{
      number: "2/05/2016",
      amount_in_cents: 1000,
      currency: "USD",
      issue_date: ~D[2016-06-12]
    }
  end
end
