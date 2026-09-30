defmodule Components.Page do
  use Phoenix.Component
  import Components.Core

  def social_links(assigns) do
    ~H"""
    <ul class="social-links" aria-label="Elsewhere">
      <li>
        <.a href={url("/rss.xml")}>RSS</.a>
      </li>
      <li>
        <.ext_a href="https://twitter.com/peregrine">Twitter</.ext_a>
      </li>
      <li>
        <.ext_a href="https://bsky.app/profile/peregrine.bsky.social">Bluesky</.ext_a>
      </li>
      <li>
        <.ext_a href="https://github.com/jeregrine">GitHub</.ext_a>
      </li>
      <li>
        <.ext_a href="https://merveilles.town/@peregrine">Mastodon</.ext_a>
      </li>
    </ul>
    """
  end

  attr(:articles, :list, required: true)
  attr(:show_date, :boolean, default: true)

  def article_list(assigns) do
    ~H"""
    <ul class="article-list">
      <li :for={a <- @articles}>
        <.date :if={@show_date} dt={a.created} />
        <.a href={url(a)}><%= a.title %></.a>
      </li>
    </ul>
    """
  end
end
