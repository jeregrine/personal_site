defmodule Build do
  @output_dir "./output"

  def build() do
    File.rm_rf!(@output_dir)
    File.mkdir_p!(@output_dir)
    posts = Blog.published()

    render_file(Path.join(@output_dir, "index.html"), PersonalSite.index(%{posts: posts}))

    for post <- posts do
      dir = Path.join([@output_dir, post.path])
      File.mkdir_p!(dir)
      render_file(Path.join([dir, "index.html"]), PersonalSite.post(%{post: post}))
    end

    :ok
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    File.write!(path, safe)
  end
end
