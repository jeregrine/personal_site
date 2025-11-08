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
    <.title><%= @post.title %></.title>
    <p class="text-sm text-stone-400 pb-1">
      <.date dt={@post.created} />
      <.icon class="h-1 w-1" name="hero-clock-solid" />
      <.read_time content={@post.body} />
      <div :if={@post.url} class="text-xs text-stone-400">
        Originally posted on Phoenix Files at
        <.ext_a href={@post.url}><%= @post.url %></.ext_a>
      </div>
    </p>

    <div class="prose">
      <%= raw(@post.body) %>
    </div>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
    <p class="text-md text-stone-600 py-3">
      Writings
    </p>
    <.article_list articles={@posts} />

    <hr class="my-8" />
    <p class="text-md text-stone-600 py-3">Keep Up</p>
    <.social_links />
    </.layout>
    """
  end

  def about(assigns) do
    ~H"""
    <.layout>
    <.title>About me</.title>

    <p class="py-3">
      My name is Jason. Known on the internet as peregrine, I am a software engineer and entrepreneur.
      Currently with <.ext_a href="https://www.strivepharmacy.com/">Strive</.ext_a> building software to help compounding pharmacies thrive.
    </p>
    <p class="py-3">
      Previously with <.ext_a href="https://www.trueanomaly.space">True Anomaly</.ext_a> working on orbital dynamics. <.ext_a href="https://fly.io">Fly.io</.ext_a> writing for Phoenix Files and working on the dashboard. Before that, I co-founded and ran
      <.ext_a href="https://rokkincat.com/">RokkinCat</.ext_a> a software consultancy for 10 years. I am passionate about helping people build a better future. I am also a big fan of open source software and have been a core contributor to the
      <.ext_a href="https://www.phoenixframework.org/">Phoenix Framework</.ext_a>.
    </p>
    <hr class="my-8" />
    <p class="text-lg text-stone-700 py-3">Follow me</p>

    <.social_links />

    <hr class="my-8" />
    <p class="text-lg text-stone-700 py-3">Talks and Podcasts</p>
    <ul class="text-stone-800 flex flex-col gap-4">
      <li>
        <div class="text-stone-400 text-sm pr-3">2023 Elixir Wizards Podcast</div>
        <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s10-e11-chris-jason-future-phoenix-elixir">
          Chris McCord and Jason Stiebs on the Future of Phoenix
        </.ext_a>
      </li>
      <li>
        <div class="text-stone-400 text-sm pr-3">2023 Elixif Conf</div>
        <.ext_a href="https://www.youtube.com/watch?v=cQp_Gxh_Jv0">
          A LiveView is a Process
        </.ext_a>
      </li>
      <li>
        <div class="text-stone-400 text-sm pr-3">2023 Thinking Elixir Podcast</div>
        <.ext_a href="https://podcast.thinkingelixir.com/152">
          Rust and Elixir Play Great Together
        </.ext_a>
      </li>
      <li>
        <div class="text-stone-400 text-sm pr-3">2022 Elixir Conf</div>
        <.ext_a href="https://www.youtube.com/watch?v=INgpJ3eIKZY">
          I was wrong about LiveView
        </.ext_a>
      </li>
      <li>
        <div class="text-stone-400 text-sm pr-3">2022 Elixir Wizards Podcast</div>
        <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s9-e5-jasonstiebs-liveview">
          on LiveView at RokkinCat
        </.ext_a>
      </li>
      <li>
        <div class="text-stone-400 text-sm pr-3">2016 ElixirConf</div>
        <.ext_a href="https://www.youtube.com/watch?v=yI5J2P9kcBQ">
          WebRTC and Phoenix, when μ Seconds aren't Fast Enough
        </.ext_a>
      </li>
    </ul>
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
