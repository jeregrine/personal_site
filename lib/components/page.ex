defmodule Components.Page do
  use Phoenix.Component
  import Components.Core

  def social_links(assigns) do
    ~H"""
    <ul class="flex flex-wrap gap-4 text-sm font-mono">
      <li>
        <.ext_a href={url("/rss.xml")} class="text-[#6B6560] hover:text-[#B8860B]">rss</.ext_a>
      </li>
      <li class="text-[#D4CFC7]">/</li>
      <li>
        <.ext_a href="https://bsky.app/profile/peregrine.bsky.social" class="text-[#6B6560] hover:text-[#B8860B]">bsky</.ext_a>
      </li>
      <li class="text-[#D4CFC7]">/</li>
      <li>
        <.ext_a href="https://github.com/jeregrine" class="text-[#6B6560] hover:text-[#B8860B]">github</.ext_a>
      </li>
      <li class="text-[#D4CFC7]">/</li>
      <li>
        <.ext_a href="https://merveilles.town/@peregrine" class="text-[#6B6560] hover:text-[#B8860B]">mastodon</.ext_a>
      </li>
    </ul>
    """
  end

  attr(:articles, :list, required: true)
  attr(:show_date, :boolean, default: true)

  def article_list(assigns) do
    ~H"""
    <div class="flex flex-col">
      <.a
        :for={a <- @articles}
        href={url(a)}
        class="group article-row flex flex-col lg:flex-row lg:items-baseline py-3 -mx-3 px-3 gap-1 lg:gap-4 border-b border-[#E8E4DD] last:border-b-0"
      >
        <.date :if={@show_date} dt={a.created} class="text-[#8B8580] text-sm shrink-0" />
        <span class="flex-grow text-[#2D2926] group-hover:text-[#5C4A1F] transition-colors">
          <%= if !Blog.dev_mode?() && a.url do %>
            <%= a.title %>
            <.icon class="w-3 h-3 ml-1 opacity-30 group-hover:opacity-60" name="hero-arrow-top-right-on-square" />
          <% else %>
            <%= a.title %>
          <% end %>
        </span>
      </.a>
    </div>
    """
  end
end
