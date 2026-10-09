defmodule PersonalSiteTest do
  use ExUnit.Case

  test "renders the homepage without posts" do
    {["index.html"], rendered} = Build.index([])
    html = rendered |> Phoenix.HTML.Safe.to_iodata() |> IO.iodata_to_binary()

    assert html =~ "Jason"
    assert html =~ "https://twitter.com/peregrine"
    assert html =~ "family=Inter"
    assert html =~ "Fira+Mono"
    refute html =~ "geometric-accent"
    refute html =~ "mx-auto"
  end

  test "renders post dates and links without a column layout" do
    post =
      Post.build(
        "A long article title.md",
        %{created: ~D[2024-02-20], status: ["published"], tags: [], url: nil},
        "<p>Hello</p>"
      )

    {["index.html"], rendered} = Build.index([post])
    html = rendered |> Phoenix.HTML.Safe.to_iodata() |> IO.iodata_to_binary()

    assert html =~ ~s(<ul class="article-list">)
    assert html =~ ~s(datetime="2024-02-20")
    assert html =~ "A long article title"
    refute html =~ "lg:flex-row"
  end

  @tag :tmp_dir
  test "writes explicit HTML filenames and extensionless routes", %{tmp_dir: tmp_dir} do
    File.cd!(tmp_dir, fn ->
      Build.render_file(Build.about())
      Build.render_file({["b", "example"], PersonalSite.about(%{})})

      assert File.regular?("output/about/index.html")
      assert File.regular?("output/b/example/index.html")
    end)
  end

  test "renders an RSS feed without posts" do
    {["rss.xml"], {:safe, rendered}} = Build.rss([])
    xml = IO.iodata_to_binary(rendered)

    assert xml =~ "<rss"
    refute xml =~ "<item>"
  end

  test "converts Markdown with the native renderer" do
    html = Post.convert("example.md", "Hello from **Elixir**!", %{}, [])

    assert html =~ "<strong>Elixir</strong>"
  end

  test "highlights multiple languages with Lumis and the light theme" do
    for {language, code} <- [
          {"elixir", ~s|IO.puts("hello")|},
          {"sh", ~s|echo "hello"|},
          {"javascript", ~s|console.log("hello")|},
          {"rust", ~s|fn main() { println!("hello"); }|}
        ] do
      html = Post.convert("example.md", "```#{language}\n#{code}\n```", %{}, [])

      assert html =~ ~s(<pre class="lumis")
      assert html =~ "background-color: #ffffff"
      assert html =~ "color: #1f2328"
      assert html =~ ~s(<span style="color:)
    end
  end

  test "renders code without a known language and escapes HTML" do
    for language <- ["", "not-a-language"] do
      html =
        Post.convert(
          "example.md",
          "```#{language}\n<script>alert('hello')</script>\n```",
          %{},
          []
        )

      assert html =~ "<pre"
      assert html =~ "&lt;script&gt;"
      refute html =~ "<script>"
    end
  end

  test "serves the source stylesheet without an asset build" do
    conn = Plug.Test.conn(:get, "/assets/app.css")
    conn = DevServer.call(conn, DevServer.init([]))

    assert conn.status == 200
    assert Plug.Conn.get_resp_header(conn, "content-type") == ["text/css; charset=utf-8"]
    assert conn.resp_body == File.read!("assets/css/app.css")
  end

  test "serves the about page" do
    conn = Plug.Test.conn(:get, "/about")
    conn = DevServer.call(conn, DevServer.init([]))

    assert conn.status == 200
    assert conn.resp_body =~ "About"
    assert conn.resp_body =~ "Staff Software Engineer"
    assert conn.resp_body =~ "Sprites"
  end

  test "serves RSS with an XML content type" do
    conn = Plug.Test.conn(:get, "/rss.xml")
    conn = DevServer.call(conn, DevServer.init([]))

    assert conn.status == 200

    assert Plug.Conn.get_resp_header(conn, "content-type") == [
             "application/rss+xml; charset=utf-8"
           ]
  end
end
