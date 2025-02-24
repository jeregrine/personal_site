defmodule PersonalSite do
  use Phoenix.Component
  import Components.Core
  import Components.Layout
  import Components.Page
  import Phoenix.HTML

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
      Writing
    </p>
    <.article_list articles={@posts} />

    <hr class="my-8" />
    <p class="text-md text-stone-600 py-3">Keep Up</p>
    <.social_links />
    </.layout>
    """
  end
end
