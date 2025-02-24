defmodule Components.Page do
  use Phoenix.Component
  import Components.Core

  def social_links(assigns) do
    ~H"""
    <ul class="text-stone-800">
      <li>
        RSS Feed:
        <.ext_a href={url("/rss")}>RSS</.ext_a>
      </li>
      <li>
        Twitter:
        <.ext_a href="https://twitter.com/peregrine">@peregrine</.ext_a>
      </li>
      <li>
        Mastodon:
        <.ext_a href="https://merveilles.town/@peregrine">@peregrine</.ext_a>
      </li>
      <li>
        Bsky:
        <.ext_a href="https://bsky.app/profile/peregrine.bsky.social">@peregrine.bsky.social</.ext_a>
      </li>
      <li>
        Github:
        <.ext_a href="https://github.com/jeregrine">jeregrine</.ext_a>
      </li>
    </ul>
    """
  end

  attr(:articles, :list, required: true)
  attr(:show_date, :boolean, default: true)

  def article_list(assigns) do
    ~H"""
    <div class="flex flex-col gap-2">
      <.a :for={a <- @articles} href={url(a)} class="flex flex-row items-center">
        <.date :if={@show_date} dt={a.created} class=" text-stone-400 text-sm pr-3 min-w-28" />
        <span class="flex-grow">
          <%= if a.url do %>
            <%= a.title %><.icon class="w-2 h-2 underline" name="hero-arrow-top-right-on-square" />
          <% else %>
            <%= a.title %>
          <% end %>
        </span>
      </.a>
    </div>
    """
  end
end
