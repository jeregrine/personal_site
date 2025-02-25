defmodule Build do
  @output_dir "./output"

  def build() do
    File.rm_rf!(@output_dir)
    File.mkdir_p!(@output_dir)
    posts = Blog.published()

    index(posts)
    dir = Path.join([@output_dir, "about"])
    File.mkdir_p!(dir)
    render_file(Path.join([dir, "index.html"]), PersonalSite.about(%{}))

    for post <- posts do
      dir = Path.join([@output_dir, post.path])
      File.mkdir_p!(dir)
      render_file(Path.join([dir, "index.html"]), PersonalSite.post(%{post: post}))
    end

    last_build_date = hd(Enum.sort_by(posts, & &1.created, &>/2)).created

    safe =
      PersonalSite.rss(%{articles: posts, last_build_date: last_build_date})
      |> XML.Engine.encode_to_iodata!()

    Path.join(@output_dir, "rss.xml")
    |> File.write!(safe)

    :ok
  end

  def index(posts) do
    latest = hd(posts)

    tags =
      Enum.flat_map(posts, fn a -> a.tags || [] end)
      |> Enum.frequencies()
      |> Enum.sort(fn {_, a}, {_, b} -> a > b end)
      |> Enum.map(fn {tag, _count} -> String.trim(tag) end)
      |> Enum.with_index()

    render_file(
      Path.join(@output_dir, "index.html"),
      PersonalSite.index(%{
        posts: posts,
        latest: latest,
        topics: tags,
        topic_count: Enum.count(tags)
      })
    )
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    File.write!(path, safe)
  end
end
