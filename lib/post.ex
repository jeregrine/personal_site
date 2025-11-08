defmodule Post do
  @blog_dir "b"
  @enforce_keys [:title, :published, :status, :created, :path, :body, :slug, :tags, :url]
  defstruct [:title, :url, :published, :status, :created, :path, :body, :slug, :tags]

  def build(filename, attrs, body) do
    attrs = Map.take(attrs, @enforce_keys)
    title = filename |> Path.rootname() |> Path.split() |> Enum.take(-1) |> hd

    slug =
      if attrs[:url] do
        attrs.url
        |> URI.parse()
        |> Map.get(:path)
        |> Path.rootname()
        |> Path.split()
        |> Enum.take(-1)
        |> hd
      else
        title |> Slug.slugify()
      end

    path = Path.join(["/", @blog_dir, slug, "/"])

    created =
      case Map.get(attrs, :created) do
        str when is_binary(str) -> Date.from_iso8601!(str)
        c -> c
      end

    published =
      case Map.get(attrs, :published) do
        str when is_binary(str) -> Date.from_iso8601!(str)
        _c -> created
      end

    struct!(
      __MODULE__,
      Map.to_list(attrs) ++
        [path: path, body: body, title: title, slug: slug, created: created, published: published]
    )
  end

  def parse(_filename, contents) do
    case String.split(contents, "---", trim: true, parts: 2) do
      [f, b] ->
        f =
          YamlElixir.read_from_string!(f)
          |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          |> Map.new()

        {f, b}
    end
  end

  def convert(_filepath, body, attrs, opts) do
    # Example: Convert images to custom format
    body
    |> MDEx.parse_document!(
      extension: [
        image_url_rewriter: "/assets/{@url}"
      ],
      syntax_highlight: [
        formatter: {:html_inline, theme: "github_light"}
      ]
    )
    |> MDEx.traverse_and_update(fn
      %MDEx.Image{} = node -> copy_asset(node, attrs, opts)
      node -> node
    end)
    |> MDEx.to_html!()
  end

  def copy_asset(node, attrs, opts) do
    fname = Path.split(node.url) |> List.last()

    out_path =
      Path.join([
        "output",
        "assets",
        fname
      ])

    obs_path =
      Path.dirname(opts[:from])
      |> Path.split()
      |> Enum.reverse()
      |> tl()
      |> Enum.reverse()
      |> Kernel.++(["Attachments", fname])
      |> Path.join()

    if File.exists?(obs_path) do
      File.cp!(obs_path, out_path)

      %{node | url: Path.join(["/assets", fname])}
    else
      Application.ensure_all_started(:req)
      dbg(node)
      dbg(opts)
      dbg(attrs)

      url = Path.join([attrs.url, "assets", Path.basename(node.url)])
      Req.get(url, into: File.stream!(obs_path))

      File.cp!(obs_path, out_path)
      %{node | url: Path.join(["/assets", fname])}
    end

    node
  end
end
