defmodule Components.Core do
  use Phoenix.Component

  @doc """
  Renders a back navigation link.

  ## Examples

      <.back navigate={~p"/posts"}>Back to posts</.back>
  """
  attr(:navigate, :any, required: true)
  slot(:inner_block, required: true)

  def back(assigns) do
    ~H"""
    <div class="mt-16">
      <.link
        navigate={@navigate}
        class="text-sm font-semibold leading-6 text-stone-900 hover:text-stone-700"
      >
        <.icon name="hero-arrow-left-solid" class="h-3 w-3" />
        <%= render_slot(@inner_block) %>
      </.link>
    </div>
    """
  end

  @doc """
  Renders a [Heroicon](https://heroicons.com).

  Heroicons come in three styles – outline, solid, and mini.
  By default, the outline style is used, but solid and mini may
  be applied by using the `-solid` and `-mini` suffix.

  You can customize the size and colors of the icons by setting
  width, height, and background color classes.

  Icons are extracted from the `deps/heroicons` directory and bundled within
  your compiled app.css by the plugin in your `assets/tailwind.config.js`.

  ## Examples

      <.icon name="hero-x-mark-solid" />
      <.icon name="hero-arrow-path" class="ml-1 w-3 h-3 animate-spin" />
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
        "hover:text-sky-500 visited:text-sky-750 cursor-pointer",
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
    <a class={[ "hover:text-sky-500 visited:text-sky-750 cursor-pointer", @class ]} href={@href} target="_blank" {@rest}>
      <span class="underline"><%= render_slot(@inner_block) %></span>
      <.icon class="w-2 h-2 underline mx-[-0.25rem]" name="hero-arrow-top-right-on-square" />
    </a>
    """
  end

  attr(:dt, :map, required: true)
  attr(:rest, :global)

  def date(assigns) do
    ~H"""
    <time :if={@dt != nil} datetime={@dt} {@rest}>
      <%= Calendar.strftime(@dt, "%x") %>
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

  def to_rfc822(nil) do
    ""
  end

  def to_rfc822(%Date{} = date) do
    {:ok, dt} = DateTime.new(date, ~T[12:00:00.000], "Etc/UTC")
    to_rfc822(dt)
  end

  def to_rfc822(%DateTime{} = date) do
    date
    |> Calendar.strftime("%a, %-d %b %Y %X GMT")
  end

  def to_rfc822(date) do
    date
    |> Calendar.strftime("%a, %-d %b %Y %X GMT")
  end

  attr(:rest, :global)
  slot(:inner_block, required: true)

  def title(assigns) do
    ~H"""
    <h1
      class="mb-1 mt-3 leading-2 text-3xl text-[calc(1.35em+0.55vw] font-medium text-gray-900"
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
      <%= @read_time %> min read
    </span>
    """
  end

  def url(%Post{} = post) do
    if post.url do
      post.url
    else
      # TODO full path
      post.path
    end
  end

  def url(str), do: str
end
