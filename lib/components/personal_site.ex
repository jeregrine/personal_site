defmodule PersonalSite do
  use Phoenix.Component
  import Components.Core
  import Components.Layout
  import Components.Page
  import Phoenix.HTML
  import XML.Engine

  def post(assigns) do
    ~H"""
    <.layout>
    <article>
      <header>
        <.title><%= @post.title %></.title>
        <p class="post-meta">
          <.date dt={@post.created} />
          <.read_time content={@post.body} />
        </p>
      </header>

      <p :if={@post.url} class="post-source">
        Originally published at
        <.ext_a href={@post.url}><%= @post.url %></.ext_a>
      </p>

      <div class="post-body">
        <%= raw(@post.body) %>
      </div>
    </article>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
    <.article_list articles={@posts} />
    <.social_links />
    </.layout>
    """
  end

  def about(assigns) do
    ~H"""
    <.layout>
    <article>
      <.title>About</.title>

      <div>
        <p>
          I'm Jason, known online as peregrine. Software engineer and entrepreneur.
        </p>
        <p>
          I'm back at <.ext_a href="https://fly.io">Fly.io</.ext_a> as a Staff Software Engineer working on
          <.ext_a href="https://sprites.dev">Sprites</.ext_a>.
        </p>
        <p>
          Previously: <.ext_a href="https://www.strivepharmacy.com/">Strive</.ext_a> (software for compounding pharmacies),
          <.ext_a href="https://www.trueanomaly.space">True Anomaly</.ext_a> (orbital dynamics),
          Fly.io (Phoenix Files, dashboard),
          and co-founded <.ext_a href="https://rokkincat.com/">RokkinCat</.ext_a> which I ran for 10 years.
        </p>
        <p>
          Core contributor to the <.ext_a href="https://www.phoenixframework.org/">Phoenix Framework</.ext_a>.
        </p>
      </div>

      <.social_links />

      <section>
        <h2>Talks & Podcasts</h2>
        <ul class="talks">
          <li>
            <div class="talk-date">2023 · Elixir Wizards</div>
            <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s10-e11-chris-jason-future-phoenix-elixir">
              Chris McCord and Jason Stiebs on the Future of Phoenix
            </.ext_a>
          </li>
          <li>
            <div class="talk-date">2023 · ElixirConf</div>
            <.ext_a href="https://www.youtube.com/watch?v=cQp_Gxh_Jv0">
              A LiveView is a Process
            </.ext_a>
          </li>
          <li>
            <div class="talk-date">2023 · Thinking Elixir</div>
            <.ext_a href="https://podcast.thinkingelixir.com/152">
              Rust and Elixir Play Great Together
            </.ext_a>
          </li>
          <li>
            <div class="talk-date">2022 · ElixirConf</div>
            <.ext_a href="https://www.youtube.com/watch?v=INgpJ3eIKZY">
              I was wrong about LiveView
            </.ext_a>
          </li>
          <li>
            <div class="talk-date">2022 · Elixir Wizards</div>
            <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s9-e5-jasonstiebs-liveview">
              on LiveView at RokkinCat
            </.ext_a>
          </li>
          <li>
            <div class="talk-date">2016 · ElixirConf</div>
            <.ext_a href="https://www.youtube.com/watch?v=yI5J2P9kcBQ">
              WebRTC and Phoenix, when μ Seconds aren't Fast Enough
            </.ext_a>
          </li>
        </ul>
      </section>
    </article>
    </.layout>
    """
  end

  def rss(assigns) do
    ~X"""
    <?xml version="1.0" encoding="utf-8"?>
    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <title>Jason Stieb's Writing</title>
        <link><%= url("/") %></link>
        <atom:link href="<%= url("/rss") %>" rel="self" type="application/rss+xml" />
        <description>Jason Stiebs's Personal Writing</description>
        <language>en</language>
        <copyright>Copyright <%= DateTime.utc_now.year %> Jason Stiebs</copyright>
        <lastBuildDate><%= @last_build_date |> to_rfc822 %></lastBuildDate>
        <ttl>60</ttl>

        <%= for article <- @articles do %>
          <item>
            <title><%= article.title %></title>
            <link><%= url(article) %></link>
            <guid><%= url(article) %></guid>
            <description>
            <![CDATA[

            <%= truncate(article.body) %>

            ]]>
            </description>
            <pubDate><%= article.created |> to_rfc822 %></pubDate>
            <source url="~">Jason Stiebs's Writing</source>
          </item>
        <% end %>
      </channel>
    </rss>


    """
  end
end
