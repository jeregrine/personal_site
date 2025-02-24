defmodule Post do
  @blog_dir "b"
  @enforce_keys [:title, :published, :status, :created, :path, :body, :slug]
  defstruct [:title, :url, :published, :status, :created, :path, :body, :slug]

  def build(filename, attrs, body) do
    attrs = Map.take(attrs, @enforce_keys)
    title = filename |> Path.rootname() |> Path.split() |> Enum.take(-1) |> hd

    slug =
      if attrs[:url] do
        attrs.url |> URI.parse() |> Map.get(:path)
      else
        title |> Slug.slugify()
      end

    path = Path.join(["/", @blog_dir, slug, "/"])

    dbg()

    struct!(
      __MODULE__,
      Map.to_list(attrs) ++ [path: path, body: body, title: title, slug: slug]
    )
  end

  def parse(filename, contents) do
    case String.split(contents, "---", trim: true, parts: 2) do
      [f, b] ->
        f =
          YamlElixir.read_from_string!(f)
          |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          |> Map.new()

        {f, b}
    end
  end

  def convert(_filepath, body, _attrs, _opts) do
    body |> MDEx.to_html!(body)
  end
end
