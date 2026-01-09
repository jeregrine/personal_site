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
      <header class="mb-6 pb-4 border-b border-[#E8E4DD]">
        <.title><%= @post.title %></.title>
        <p class="text-sm text-[#8B8580] flex items-center gap-3 font-mono">
          <.date dt={@post.created} />
          <span class="text-[#D4CFC7]">·</span>
          <.read_time content={@post.body} />
        </p>
      </header>

      <div :if={@post.url} class="text-sm text-[#6B6560] mb-6 py-3 px-4 bg-[#F0EDE8] border-l-2 border-[#B8860B] font-mono">
        <span class="opacity-70">via</span>
        <.ext_a href={@post.url}><%= @post.url %></.ext_a>
      </div>

      <div class="prose prose-lg max-w-none
        prose-headings:font-medium prose-headings:text-[#1A1A1A] prose-headings:font-mono
        prose-p:text-[#2D2926] prose-p:leading-relaxed
        prose-a:text-[#5C4A1F] prose-a:no-underline hover:prose-a:text-[#B8860B]
        prose-a:border-b prose-a:border-[#B8860B]/30 hover:prose-a:border-[#B8860B]
        prose-strong:text-[#1A1A1A] prose-strong:font-medium
        prose-code:text-[#5C4A1F] prose-code:bg-[#F0EDE8] prose-code:px-1.5 prose-code:py-0.5 prose-code:rounded prose-code:font-mono prose-code:text-[0.9em]
        prose-pre:bg-[#2A2622] prose-pre:border-0 prose-pre:rounded
        prose-blockquote:border-l-[#B8860B] prose-blockquote:text-[#4A4540] prose-blockquote:not-italic
        prose-li:text-[#2D2926]
        prose-hr:border-[#E8E4DD]">
        <%= raw(@post.body) %>
      </div>
    </article>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
    <section class="mb-10">
      <.article_list articles={@posts} />
    </section>

    <hr class="my-8" />

    <section>
      <.social_links />
    </section>
    </.layout>
    """
  end

  def about(assigns) do
    ~H"""
    <.layout>
    <article>
      <.title>About</.title>

      <div class="space-y-4 text-[#2D2926] mb-10">
        <p class="leading-relaxed">
          I'm Jason, known online as <span class="text-[#5C4A1F]">peregrine</span>. Software engineer and entrepreneur.
        </p>
        <p class="leading-relaxed">
          Currently at <.ext_a href="https://www.strivepharmacy.com/">Strive</.ext_a> building software for compounding pharmacies.
          Previously: <.ext_a href="https://www.trueanomaly.space">True Anomaly</.ext_a> (orbital dynamics),
          <.ext_a href="https://fly.io">Fly.io</.ext_a> (Phoenix Files, dashboard),
          and co-founded <.ext_a href="https://rokkincat.com/">RokkinCat</.ext_a> which I ran for 10 years.
        </p>
        <p class="leading-relaxed">
          Core contributor to the <.ext_a href="https://www.phoenixframework.org/">Phoenix Framework</.ext_a>.
        </p>
      </div>

      <hr class="my-8" />

      <section class="mb-10">
        <.social_links />
      </section>

      <hr class="my-8" />

      <section>
        <h2 class="text-xl font-medium text-[#1A1A1A] mb-6">Talks & Podcasts</h2>
        <ul class="flex flex-col gap-3">
          <li class="hybrid-card">
            <div class="text-[#8B8580] text-xs mb-1 font-mono">2023 · Elixir Wizards</div>
            <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s10-e11-chris-jason-future-phoenix-elixir">
              Chris McCord and Jason Stiebs on the Future of Phoenix
            </.ext_a>
          </li>
          <li class="hybrid-card">
            <div class="text-[#8B8580] text-xs mb-1 font-mono">2023 · ElixirConf</div>
            <.ext_a href="https://www.youtube.com/watch?v=cQp_Gxh_Jv0">
              A LiveView is a Process
            </.ext_a>
          </li>
          <li class="hybrid-card">
            <div class="text-[#8B8580] text-xs mb-1 font-mono">2023 · Thinking Elixir</div>
            <.ext_a href="https://podcast.thinkingelixir.com/152">
              Rust and Elixir Play Great Together
            </.ext_a>
          </li>
          <li class="hybrid-card">
            <div class="text-[#8B8580] text-xs mb-1 font-mono">2022 · ElixirConf</div>
            <.ext_a href="https://www.youtube.com/watch?v=INgpJ3eIKZY">
              I was wrong about LiveView
            </.ext_a>
          </li>
          <li class="hybrid-card">
            <div class="text-[#8B8580] text-xs mb-1 font-mono">2022 · Elixir Wizards</div>
            <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s9-e5-jasonstiebs-liveview">
              on LiveView at RokkinCat
            </.ext_a>
          </li>
          <li class="hybrid-card">
            <div class="text-[#8B8580] text-xs mb-1 font-mono">2016 · ElixirConf</div>
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
