defmodule Post do
  @enforce_keys [:title, :url, :published, :status, :created, :path, :body]
  defstruct [:title, :url, :published, :status, :created, :path, :body]

  def build(filename, attrs, body) do
    attrs = Map.take(attrs, @enforce_keys)
    title = filename |> Path.rootname() |> Path.split() |> Enum.take(-1) |> hd
    struct!(__MODULE__, [path: filename, body: body, title: title] ++ Map.to_list(attrs))
  end

  def parse(filename, contents) do
    case String.split(contents, "---", trim: true, parts: 2) do
      [f, b] ->
        f =
          YamlElixir.read_from_string!(f)
          |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          |> Map.new()

        {Map.put(f, :path, filename), b}
    end
  end

  def convert(_filepath, body, _attrs, _opts) do
    body |> MDEx.to_html!(body)
  end
end
