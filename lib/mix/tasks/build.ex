defmodule Mix.Tasks.Build do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    Mix.shell().info("Building...")
    Build.build()
  end
end
