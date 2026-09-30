defmodule Components.Core do
  use Phoenix.Component

  @doc """
  Renders a back navigation link.
  """
  attr(:navigate, :any, required: true)
  slot(:inner_block, required: true)

  def back(assigns) do
    ~H"""
    <div class="back-link">
      <.link
        navigate={@navigate}
      >
        <%= render_slot(@inner_block) %>
      </.link>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:href, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def a(assigns) do
    ~H"""
    <a
      class={@class}
      href={@href}
      {@rest}
    ><%= render_slot(@inner_block) %></a>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  attr(:href, :string, default: "")
  slot(:inner_block, required: true)

  def ext_a(assigns) do
    ~H"""
    <a class={@class} href={@href} {@rest}><%= render_slot(@inner_block) %></a>
    """
  end

  attr(:dt, :map, required: true)
  attr(:rest, :global)

  def date(assigns) do
    ~H"""
    <time :if={@dt != nil} datetime={@dt} {@rest}>
      <%= Calendar.strftime(@dt, "%Y-%m-%d") %>
    </time>
    """
  end

  def truncate(str) do
    if String.length(str) > 300 do
      String.slice(str, 0..300) <> "..."
    else
      str
    end
  end

  def to_rfc822(nil), do: ""

  def to_rfc822(%Date{} = date) do
    {:ok, dt} = DateTime.new(date, ~T[12:00:00.000], "Etc/UTC")
    to_rfc822(dt)
  end

  def to_rfc822(%DateTime{} = date) do
    Calendar.strftime(date, "%a, %-d %b %Y %X GMT")
  end

  def to_rfc822(date) do
    Calendar.strftime(date, "%a, %-d %b %Y %X GMT")
  end

  attr(:rest, :global)
  slot(:inner_block, required: true)

  def title(assigns) do
    ~H"""
    <h1
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </h1>
    """
  end

  attr(:content, :string, required: true)
  attr(:rest, :global)

  def read_time(assigns) do
    assigns =
      assign(
        assigns,
        :read_time,
        assigns[:content]
        |> String.split(~r{(\\n|[^\w'])+})
        |> Enum.filter(fn x -> x != "" end)
        |> Enum.count()
        |> div(200)
        |> round()
      )

    ~H"""
    <span {@rest}>
      <%= @read_time %> min
    </span>
    """
  end

  def url(%Post{} = post) do
    if Blog.dev_mode?() do
      "/b/#{post.slug}/"
    else
      post.url
    end
  end

  def url(str), do: str
end
