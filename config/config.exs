import Config

config :personal_site,
  notes_path: System.get_env("NOTES_PATH") || Path.expand("~/notes/notes")
