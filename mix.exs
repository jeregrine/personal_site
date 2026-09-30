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
      {:phoenix_live_view, "~> 1.1"},
      {:mdex, "~> 0.10.0"},
      {:yaml_elixir, "~> 2.11"},
      {:slugify, "~> 1.3"},
      {:plug, "~> 1.19"},
      {:bandit, "~> 1.9"},
      {:req, "~> 0.5.16"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "compile"],
      publish: [
        "clean",
        "compile",
        "build"
      ]
    ]
  end
end
