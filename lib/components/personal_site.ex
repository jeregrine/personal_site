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
    <p class="text-sm text-[#707a8c] pb-4 flex items-center gap-2 font-mono">
      <.date dt={@post.created} />
      <span class="text-[#707a8c]">•</span>
      <.icon class="h-3 w-3" name="hero-clock-solid" />
      <.read_time content={@post.body} />
    </p>
    <div :if={@post.url} class="text-xs text-[#cbccc6] mb-6 p-3 tui-box">
      <span class="text-[#95e6cb]">ℹ Originally posted on Phoenix Files at</span>
      <.ext_a href={@post.url}><%= @post.url %></.ext_a>
    </div>

    <div class="prose prose-invert prose-cyan max-w-none
      prose-headings:text-[#ffd580] prose-headings:font-bold
      prose-p:text-[#cbccc6] prose-p:leading-relaxed
      prose-a:text-[#5ccfe6] prose-a:no-underline hover:prose-a:text-[#73d0ff]
      prose-strong:text-[#ffcc66] prose-strong:font-bold
      prose-code:rounded
      prose-pre:bg-[#232834] prose-pre:border prose-pre:border-[#707a8c]
      prose-blockquote:border-l-[#5ccfe6] prose-blockquote:text-[#cbccc6]
      prose-li:text-[#cbccc6]">
      <%= raw(@post.body) %>
    </div>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
    <div class="mb-6">
      <p class="text-lg text-[#ffd580] font-bold mb-1">
        Writings
      </p>
      <p class="text-sm text-[#707a8c]">Recent posts and articles</p>
    </div>
    <.article_list articles={@posts} />

    <hr class="my-8 border-[#707a8c]" />
    <div class="mb-4">
      <p class="text-lg text-[#ffd580] font-bold">
        Keep Up
      </p>
    </div>
    <.social_links />
    </.layout>
    """
  end

  def about(assigns) do
    ~H"""
    <.layout>
    <.title>About me</.title>

    <p class="py-3 text-[#cbccc6] leading-relaxed">
      My name is Jason. Known on the internet as <span class="text-[#95e6cb]">peregrine</span>, I am a software engineer and entrepreneur.
      Currently with <.ext_a href="https://www.strivepharmacy.com/">Strive</.ext_a> building software to help compounding pharmacies thrive.
    </p>
    <p class="py-3 text-[#cbccc6] leading-relaxed">
      Previously with <.ext_a href="https://www.trueanomaly.space">True Anomaly</.ext_a> working on orbital dynamics. <.ext_a href="https://fly.io">Fly.io</.ext_a> writing for Phoenix Files and working on the dashboard. Before that, I co-founded and ran
      <.ext_a href="https://rokkincat.com/">RokkinCat</.ext_a> a software consultancy for 10 years. I am passionate about helping people build a better future. I am also a big fan of open source software and have been a core contributor to the
      <.ext_a href="https://www.phoenixframework.org/">Phoenix Framework</.ext_a>.
    </p>
    <hr class="my-8 border-[#707a8c]" />
    <div class="mb-4">
      <p class="text-lg text-[#ffd580] font-bold">
        Follow me
      </p>
    </div>

    <.social_links />

    <hr class="my-8 border-[#707a8c]" />
    <div class="mb-6">
      <p class="text-lg text-[#ffd580] font-bold">
        Talks and Podcasts
      </p>
    </div>
    <ul class="text-[#cbccc6] flex flex-col gap-4">
      <li class="tui-box hover:border-[#5ccfe6] transition-colors duration-150">
        <div class="text-[#707a8c] text-xs mb-1 font-mono">
          <span class="text-[#f28779]">[</span>2023<span class="text-[#f28779]">]</span> Elixir Wizards Podcast
        </div>
        <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s10-e11-chris-jason-future-phoenix-elixir">
          Chris McCord and Jason Stiebs on the Future of Phoenix
        </.ext_a>
      </li>
      <li class="tui-box hover:border-[#5ccfe6] transition-colors duration-150">
        <div class="text-[#707a8c] text-xs mb-1 font-mono">
          <span class="text-[#f28779]">[</span>2023<span class="text-[#f28779]">]</span> Elixir Conf
        </div>
        <.ext_a href="https://www.youtube.com/watch?v=cQp_Gxh_Jv0">
          A LiveView is a Process
        </.ext_a>
      </li>
      <li class="tui-box hover:border-[#5ccfe6] transition-colors duration-150">
        <div class="text-[#707a8c] text-xs mb-1 font-mono">
          <span class="text-[#f28779]">[</span>2023<span class="text-[#f28779]">]</span> Thinking Elixir Podcast
        </div>
        <.ext_a href="https://podcast.thinkingelixir.com/152">
          Rust and Elixir Play Great Together
        </.ext_a>
      </li>
      <li class="tui-box hover:border-[#5ccfe6] transition-colors duration-150">
        <div class="text-[#707a8c] text-xs mb-1 font-mono">
          <span class="text-[#f28779]">[</span>2022<span class="text-[#f28779]">]</span> Elixir Conf
        </div>
        <.ext_a href="https://www.youtube.com/watch?v=INgpJ3eIKZY">
          I was wrong about LiveView
        </.ext_a>
      </li>
      <li class="tui-box hover:border-[#5ccfe6] transition-colors duration-150">
        <div class="text-[#707a8c] text-xs mb-1 font-mono">
          <span class="text-[#f28779]">[</span>2022<span class="text-[#f28779]">]</span> Elixir Wizards Podcast
        </div>
        <.ext_a href="https://smartlogic.io/podcast/elixir-wizards/s9-e5-jasonstiebs-liveview">
          on LiveView at RokkinCat
        </.ext_a>
      </li>
      <li class="tui-box hover:border-[#5ccfe6] transition-colors duration-150">
        <div class="text-[#707a8c] text-xs mb-1 font-mono">
          <span class="text-[#f28779]">[</span>2016<span class="text-[#f28779]">]</span> ElixirConf
        </div>
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
