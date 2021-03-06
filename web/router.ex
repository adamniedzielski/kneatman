defmodule Kneatman.Router do
  use Kneatman.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Kneatman do
    pipe_through :browser # Use the default browser stack

    get "/", GeneratorController, :new
    post "/fetch_invoice_details", GeneratorController, :fetch_invoice_details
    post "/generate_document", GeneratorController, :generate_document
  end
end
