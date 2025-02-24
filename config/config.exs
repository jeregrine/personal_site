import Config

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.0.8",
  personal_site: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../output/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
