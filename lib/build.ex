defmodule Build do
  @output_dir "./output"

  def build() do
    File.rm_rf!(@output_dir)
    File.mkdir_p!(@output_dir)
    assets_dir = Path.join(@output_dir, "assets")
    File.mkdir_p!(assets_dir)
    File.cp!("assets/css/app.css", Path.join(assets_dir, "app.css"))

    for f <- Path.wildcard("./assets/favicon*.*") do
      fname = Path.basename(f)
      File.cp!(f, Path.join("./output/assets", fname))
    end

    posts = Blog.published()

    [index(posts), about(), posts(posts), rss(posts)]
    |> List.flatten()
    |> Enum.each(&render_file/1)

    :ok
  end

  def post(post) do
    {[post.path], PersonalSite.post(%{post: post})}
  end

  def posts(posts) do
    for post <- posts do
      post(post)
    end
  end

  def rss(posts) do
    last_build_date =
      case Enum.sort_by(posts, & &1.created, &>/2) do
        [latest | _] -> latest.created
        [] -> Date.utc_today()
      end

    safe =
      PersonalSite.rss(%{articles: posts, last_build_date: last_build_date})
      |> XML.Engine.encode_to_iodata!()

    {["rss.xml"], {:safe, safe}}
  end

  def about() do
    {["about", "index.html"], PersonalSite.about(%{})}
  end

  def index(posts) do
    latest = List.first(posts)

    tags =
      Enum.flat_map(posts, fn a -> a.tags || [] end)
      |> Enum.frequencies()
      |> Enum.sort(fn {_, a}, {_, b} -> a > b end)
      |> Enum.map(fn {tag, _count} -> String.trim(tag) end)
      |> Enum.with_index()

    {["index.html"],
     PersonalSite.index(%{
       posts: posts,
       latest: latest,
       topics: tags,
       topic_count: Enum.count(tags)
     })}
  end

  def render_file({fname, {:safe, safe}}) do
    dir = Path.expand("./output")

    path =
      List.flatten([dir | fname])
      |> Path.join()

    File.mkdir_p!(Path.dirname(path))

    File.write!(path, safe)
  end

  def render_file({fname, rendered}) do
    dir = Path.expand("./output")

    path =
      List.flatten([dir, fname])
      |> Path.join()

    safe =
      Phoenix.HTML.Safe.to_iodata(rendered)
      |> to_string()
      |> Phoenix.LiveView.HTMLFormatter.format(file: path)

    path = if Path.extname(path) == "", do: Path.join(path, "index.html"), else: path
    File.mkdir_p!(Path.dirname(path))
    File.write!(path, safe)
  end
end
