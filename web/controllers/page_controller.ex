defmodule Kneatman.PageController do
  use Kneatman.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
