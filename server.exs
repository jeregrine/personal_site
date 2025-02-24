# DO THIS TOO
# fswatch -o -r lib/ | xargs -n1 -I{} mix publish
Mix.install([:plug, :bandit])

defmodule Server do
  use Plug.Builder

  plug(Plug.Static,
    at: "/",
    from: "./output"
  )

  plug(:not_found)

  def not_found(conn, _params) do
    dbg(conn)
    dbg(Path.join(["./output", conn.request_path, "index.html"]))

    if File.exists?(Path.join(["./output", conn.request_path, "index.html"])) do
      send_file(conn, 200, Path.join(["./output", conn.request_path, "index.html"]))
    else
      send_resp(conn, 404, "not found")
    end
  end
end

Bandit.start_link(plug: Server)

Process.sleep(:infinity)
