# Woodcraft

Elixir/Phoenix web application.

**Parent configuration**: See `~/cowork/dev/CLAUDE.md` for shared workflow, task management, and core principles.

## Technology Stack

- **Language**: Elixir 1.17+
- **Framework**: Phoenix (with LiveView)
- **Database**: PostgreSQL 16
- **Assets**: Node.js 22 (esbuild + tailwind)

## Development Environment

Enter the devenv shell to access all tools:

```fish
devenv shell
```

### Available Commands

| Command   | Description                          |
|-----------|--------------------------------------|
| `server`  | Start Phoenix server (localhost:4000)|
| `iex`     | Interactive Elixir shell with app    |
| `test`    | Run test suite                       |
| `routes`  | Display all routes                   |
| `deps`    | Fetch dependencies                   |
| `setup`   | Run `mix setup` (deps, db, assets)   |
| `migrate` | Run database migrations              |
| `reset`   | Reset database (drop, create, migrate)|

### First Time Setup

```fish
devenv shell
mix phx.new . --app woodcraft  # Generate Phoenix app in current directory
setup                          # Run mix setup
server                         # Start development server
```

### Running Tests

```fish
devenv shell
test              # Run all tests
mix test --cover  # With coverage
mix test path/to/test.exs:42  # Specific test at line
```

## Project Structure

```
lib/
├── woodcraft/           # Business logic (contexts)
│   ├── application.ex
│   └── repo.ex
├── woodcraft_web/       # Web layer
│   ├── components/      # Phoenix components
│   ├── controllers/     # Request handlers
│   ├── live/           # LiveView modules
│   └── router.ex
priv/
├── repo/migrations/     # Ecto migrations
└── static/             # Static assets
test/
├── woodcraft/          # Context tests
├── woodcraft_web/      # Controller/LiveView tests
└── support/            # Test helpers
```

## Available Elixir Skills

Elixir/Phoenix skills are available for guidance:

- `elixir-essentials`: Core Elixir patterns and idioms
- `ecto-essentials`: Database operations with Ecto
- `phoenix-liveview-essentials`: LiveView development
- `phoenix-channels-essentials`: Real-time communication
- `testing-essentials`: ExUnit testing patterns
- `oban-essentials`: Background job processing
- `security-essentials`: Security best practices

Invoke with `/elixir-phoenix-guide:<skill-name>` when working on related features.

## Code Style

- Run `mix format` before committing
- Follow [Elixir Style Guide](https://github.com/christopheradams/elixir_style_guide)
- Use contexts to organize business logic
- Keep controllers thin, push logic to contexts
- Write comprehensive tests for contexts

## Database

PostgreSQL runs automatically via devenv services:

```fish
# In devenv shell, PostgreSQL is available at localhost:5432
# Databases: woodcraft_dev, woodcraft_test
```

Manual database operations:

```fish
mix ecto.create      # Create database
mix ecto.migrate     # Run pending migrations
mix ecto.rollback    # Rollback last migration
mix ecto.gen.migration <name>  # Generate migration
```
