use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :blog, Blog.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure mailer for test mode
config :blog, Blog.Mailer,
  adapter: Swoosh.Adapters.Test

# Configure your database
{whoami, _} = System.cmd("whoami", [])
whoami = String.replace(whoami, "\n", "")

config :blog, Blog.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "blog_test",
  hostname: "localhost",
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || whoami,
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || nil,
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 60_000
