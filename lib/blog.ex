defmodule Blog do
  use NimblePublisher,
    build: Post,
    from: Path.expand("~/notes/Blog/*.md"),
    as: :posts,
    highlighters: [],
    parser: Post,
    html_converter: Post

  def all, do: @posts

  def published,
    do:
      @posts
      |> Enum.filter(&("published" in &1.status))
      |> Enum.sort_by(& &1.published, {:desc, Date})

  def by_slug(slug) do
    published()
    |> Enum.find(fn post -> post.slug == slug end)
  end

  def dev_mode?() do
    Application.get_env(:personal_site, :dev_mode, false)
  end
end
