{ pkgs, lib, config, inputs, ... }:

{
  # Elixir/Erlang development
  languages.elixir = {
    enable = true;
    package = pkgs.elixir_1_17;
  };

  languages.erlang = {
    enable = true;
  };

  # Node.js for Phoenix assets
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_22;
  };

  # System packages
  packages = [
    pkgs.inotify-tools  # For live reload on Linux
    pkgs.postgresql_16  # PostgreSQL client tools
    pkgs.git
  ];

  # PostgreSQL service for development
  services.postgres = {
    enable = true;
    package = pkgs.postgresql_16;
    initialDatabases = [
      { name = "woodcraft_dev"; }
      { name = "woodcraft_test"; }
    ];
    listen_addresses = "127.0.0.1";
  };

  # Environment variables
  env = {
    MIX_ENV = "dev";
    DATABASE_URL = "postgres://localhost/woodcraft_dev";
    PHX_HOST = "localhost";
  };

  # Scripts for common tasks
  scripts = {
    server.exec = "mix phx.server";
    iex.exec = "iex -S mix";
    test.exec = "mix test";
    routes.exec = "mix phx.routes";
    deps.exec = "mix deps.get";
    setup.exec = "mix setup";
    migrate.exec = "mix ecto.migrate";
    reset.exec = "mix ecto.reset";
  };

  # Shell initialization
  enterShell = ''
    echo "🌲 Woodcraft - Elixir/Phoenix Development Environment"
    echo ""
    echo "Available commands:"
    echo "  server   - Start Phoenix server"
    echo "  iex      - Start IEx with project loaded"
    echo "  test     - Run tests"
    echo "  routes   - Show routes"
    echo "  deps     - Get dependencies"
    echo "  setup    - Run mix setup"
    echo "  migrate  - Run migrations"
    echo "  reset    - Reset database"
    echo ""

    # Ensure hex and rebar are installed
    if ! mix local.hex --check-installed > /dev/null 2>&1; then
      mix local.hex --force
    fi
    if ! mix local.rebar --check-installed > /dev/null 2>&1; then
      mix local.rebar --force
    fi
  '';

  # Pre-commit hooks (optional)
  pre-commit.hooks = {
    mix-format = {
      enable = true;
      entry = "mix format --check-formatted";
      files = "\\.exs?$";
    };
  };
}
