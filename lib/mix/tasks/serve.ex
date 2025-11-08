defmodule Mix.Tasks.Serve do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    Mix.shell().info("Serving on localhost:4000...")

    Application.ensure_started(:telemetry)

    {:ok, _} =
      Bandit.start_link(
        plug: DevServer,
        scheme: :http,
        port: 4000
      )

    Process.sleep(:infinity)
  end
end

defmodule DevServer do
  use Plug.Builder, log_on_halt: :info

  plug(Plug.Logger)
  plug(:page)
  plug(:static)
  plug(:not_found)

  def page(conn, _opts) do
    dbg(conn.path_info)

    case conn.path_info do
      [] ->
        posts = Blog.published()
        heex(conn, Build.index(posts))

      ["b", fname] ->
        post = Blog.by_slug(fname)

        if post do
          heex(conn, Build.post(post))
        else
          conn
        end

      ["about"] ->
        IO.puts("HELLO")
        heex(conn, Build.about())

      ["rss.xml"] ->
        IO.puts("Hello")
        heex(conn, Build.rss(Blog.published()))

      _ ->
        conn
    end
  end

  defp heex(conn, {_, rendered}) do
    resp = Phoenix.HTML.Safe.to_iodata(rendered)

    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> send_resp(200, resp)
  end

  def static(conn, _opts) do
    dir = Path.expand("./output")

    path =
      List.flatten([dir | conn.path_info])
      |> Path.join()

    path = if Path.extname(path) == "", do: Path.join(path, "index.html"), else: path

    case File.read(path) do
      {:ok, content} ->
        mime_type = MIME.from_path(path)

        conn
        |> Plug.Conn.put_resp_content_type(mime_type)
        |> send_resp(200, content)

      {:error, _reason} ->
        conn
    end
  end

  def not_found(conn, _opts) do
    send_resp(conn, 404, "not found")
  end
end
