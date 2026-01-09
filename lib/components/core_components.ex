defmodule Components.Core do
  use Phoenix.Component

  @doc """
  Renders a back navigation link.
  """
  attr(:navigate, :any, required: true)
  slot(:inner_block, required: true)

  def back(assigns) do
    ~H"""
    <div class="mt-12">
      <.link
        navigate={@navigate}
        class="text-sm font-mono text-[#6B6560] hover:text-[#B8860B] transition-colors"
      >
        <.icon name="hero-arrow-left-solid" class="h-3 w-3" />
        <%= render_slot(@inner_block) %>
      </.link>
    </div>
    """
  end

  @doc """
  Renders a [Heroicon](https://heroicons.com).
  """
  attr(:name, :string, required: true)
  attr(:class, :string, default: nil)

  def icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end

  attr(:class, :string, default: nil)
  attr(:href, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def a(assigns) do
    ~H"""
    <a
      class={[
        "text-[#5C4A1F] hover:text-[#B8860B] cursor-pointer transition-colors",
        @class
      ]}
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
    <a class={[ "text-[#5C4A1F] hover:text-[#B8860B] cursor-pointer transition-colors", @class ]} href={@href} target="_blank" {@rest}>
      <span class="border-b border-[#B8860B]/30 hover:border-[#B8860B]"><%= render_slot(@inner_block) %></span>
      <.icon class="w-2 h-2 ml-0.5 opacity-40" name="hero-arrow-top-right-on-square" />
    </a>
    """
  end

  attr(:dt, :map, required: true)
  attr(:rest, :global)

  def date(assigns) do
    ~H"""
    <time :if={@dt != nil} datetime={@dt} class="font-mono" {@rest}>
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
      class="mb-4 mt-2 leading-tight text-3xl lg:text-4xl font-medium text-[#1A1A1A]"
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
    <span class="font-mono" {@rest}>
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
