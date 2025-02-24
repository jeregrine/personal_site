defmodule PersonalSite.MixProject do
  use Mix.Project

  def project do
    [
      app: :personal_site,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_publisher, "~> 1.0"},
      {:phoenix_live_view, "~> 1.0"},
      {:mdex, "~> 0.3.3"},
      {:yaml_elixir, "~> 2.11"},
      {:tailwind, "~> 0.2", only: :dev},
      {:slugify, "~> 1.3"}
    ]
  end

  defp aliases do
    [
      setup: ["tailwind.install --if-missing"],
      publish: [
        "clean",
        "compile",
        "tailwind personal_site --minify",
        "build"
      ]
    ]
  end
end
