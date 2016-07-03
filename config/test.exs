use Mix.Config

config :kneatman, Kneatman.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

config :kneatman, :infakt_api, Kneatman.InFaktAPI.Mock
