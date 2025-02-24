defmodule PersonalSite do
  use Phoenix.Component
  import Components.Core
  import Components.Layout
  import Phoenix.HTML

  def post(assigns) do
    ~H"""
    <.layout>
      <%= raw @post.body %>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <h1>Jason's Personal website!!</h1>
      <h2>Posts!</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}> <%= post.title %> </a>
        </li>
      </ul>
    </.layout>
    """
  end
end
