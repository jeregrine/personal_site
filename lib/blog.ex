defmodule Blog do
  use NimblePublisher,
    build: Post,
    from: Path.expand("~/notes/Blog/*.md"),
    as: :posts,
    highlighters: [],
    parser: Post,
    converter: Post

  def all, do: @posts
  def published, do: @posts |> Enum.filter(&("published" in &1.status))
end
