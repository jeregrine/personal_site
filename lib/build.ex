defmodule Build do
  @output_dir "./output"

  def build() do
    File.rm_rf!(@output_dir)
    File.mkdir_p!(@output_dir)
    File.mkdir_p!(Path.join(@output_dir, "assets"))

    posts = Blog.published()

    [index(posts), about(), posts(posts), rss(posts)]
    |> List.flatten()
    |> Enum.each(&render_file/1)

    # Add CNAME file for custom domain if configured
    if cname = System.get_env("CNAME") do
      File.write!(Path.join(@output_dir, "CNAME"), cname)
    end

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
    last_build_date = hd(Enum.sort_by(posts, & &1.created, &>/2)).created

    safe =
      PersonalSite.rss(%{articles: posts, last_build_date: last_build_date})
      |> XML.Engine.encode_to_iodata!()

    {["rss.xml"], {:safe, safe}}
  end

  def about() do
    {["about", "index.html"], PersonalSite.about(%{})}
  end

  def index(posts) do
    latest = hd(posts)

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

    if fname == ["index.html"] do
      File.mkdir_p!(Path.dirname(path))
      File.write!(path, safe)
    else
      index_path = Path.join(path, "index.html")
      File.mkdir_p!(path)
      File.write!(index_path, safe)
    end
  end
end
