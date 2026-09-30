# PersonalSite

A static personal site built with Elixir, Phoenix components, NimblePublisher,
and MDEx. Bandit serves the development site.
No database, Docker, or Node.js installation is required.

Styles live in `assets/css/app.css`, using Inter for text and Fira Mono for
dates and code. There is no Tailwind, esbuild, Bun, npm, or JavaScript bundle.
Markdown code blocks use the `github_light` syntax-highlighting theme.

## Development setup

Install [mise](https://mise.jdx.dev/), then run from the repository root:

```sh
mise trust
mise install
mise exec -- mix local.hex --force
mise exec -- mix local.rebar --force
mise exec -- mix setup
```

The runtime versions are specified in `mise.toml`. `mix setup` fetches the locked
dependencies and compiles the site.
The Markdown dependencies download precompiled native libraries on supported
platforms, so the initial setup needs network access.

Start the development server:

```sh
mise exec -- mix serve --dev
```

Open <http://localhost:4000>. The server recompiles page modules on requests and
serves CSS directly, so stylesheet edits appear on refresh. Stop it with Ctrl+C
(press twice if prompted by the BEAM).

## Blog content

By default, posts are loaded from `~/notes/notes/Blog/*.md`. The site can run without
posts. To use another notes directory:

```sh
NOTES_PATH=/absolute/path/to/notes mise exec -- mix compile --force
NOTES_PATH=/absolute/path/to/notes mise exec -- mix serve --dev
```

`NOTES_PATH` is read at compile time, so recompile when changing it.
Post titles come from Markdown filenames. For example, `Blog/Hello world.md`:

```markdown
---
created: "2026-01-01"
published: "2026-01-01"
status:
  - published
tags:
  - elixir
---

Hello from **Elixir**!
```

Local image attachments belong in the notes directory's `Attachments/` folder.

## Checks and static output

```sh
mise exec -- mix test
mise exec -- mix publish
```

`mix publish` builds the static site and copies the stylesheet into `output/`;
it does not deploy anything.
