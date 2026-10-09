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
      {:nimble_publisher, "~> 2.1"},
      {:phoenix_live_view, "~> 1.2"},
      {:mdex, "~> 0.14.1"},
      {:lumis, "~> 0.10.0"},
      {:lumis_wasm_bundle_full, "~> 0.1.2"},
      {:yaml_elixir, "~> 2.12"},
      {:slugify, "~> 1.3"},
      {:plug, "~> 1.20"},
      {:bandit, "~> 1.12"},
      {:req, "~> 0.7.4"}
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
