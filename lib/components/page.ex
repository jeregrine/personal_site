defmodule Components.Page do
  use Phoenix.Component
  import Components.Core

  def social_links(assigns) do
    ~H"""
    <ul class="text-[#cbccc6] space-y-2 font-mono">
      <li class="flex items-center gap-2">
        <span class="text-[#f28779]">→</span>
        <span class="text-[#95e6cb]">RSS Feed:</span>
        <.ext_a href={url("/rss.xml")}>RSS</.ext_a>
      </li>
      <li class="flex items-center gap-2">
        <span class="text-[#f28779]">→</span>
        <span class="text-[#95e6cb]">Bsky:</span>
        <.ext_a href="https://bsky.app/profile/peregrine.bsky.social">@peregrine.bsky.social</.ext_a>
      </li>
      <li class="flex items-center gap-2">
        <span class="text-[#f28779]">→</span>
        <span class="text-[#95e6cb]">Github:</span>
        <.ext_a href="https://github.com/jeregrine">jeregrine</.ext_a>
      </li>
      <li class="flex items-center gap-2">
        <span class="text-[#f28779]">→</span>
        <span class="text-[#95e6cb]">Mastodon:</span>
        <.ext_a href="https://merveilles.town/@peregrine">@peregrine</.ext_a>
      </li>
    </ul>
    """
  end

  attr(:articles, :list, required: true)
  attr(:show_date, :boolean, default: true)

  def article_list(assigns) do
    ~H"""
    <div class="flex flex-col gap-3">
      <.a :for={a <- @articles} href={url(a)} class="flex flex-row items-center group hover:bg-[#232834] p-2 rounded transition-all duration-150 border border-transparent hover:border-[#707a8c]">
        <.date :if={@show_date} dt={a.created} class="text-[#707a8c] text-sm pr-4 min-w-32 font-mono" />
        <span class="flex-grow flex items-center gap-2">
          <span class="text-[#f28779] opacity-0 group-hover:opacity-100 transition-opacity duration-150">▸</span>
          <%= if !Blog.dev_mode?() &&  a.url do %>
            <%= a.title %><.icon class="w-2 h-2 underline ml-1" name="hero-arrow-top-right-on-square" />
          <% else %>
            <%= a.title %>
          <% end %>
        </span>
      </.a>
    </div>
    """
  end
end
