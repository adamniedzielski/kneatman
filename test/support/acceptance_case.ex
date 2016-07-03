defmodule Kneatman.AcceptanceCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      import Kneatman.Router.Helpers
    end
  end

  setup do
    {:ok, session} = Wallaby.start_session
    {:ok, session: session}
  end
end
