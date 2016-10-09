defmodule Kneatman.GeneratorView do
  use Kneatman.Web, :view

  def display_money(amount_in_cents) do
    super_unit = div(amount_in_cents, 100) |> Integer.to_string
    sub_unit = rem(abs(amount_in_cents), 100) |> Integer.to_string |> String.rjust(2, ?0)
    [super_unit, sub_unit] |> Enum.join(".")
  end
end
