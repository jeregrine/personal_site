defmodule Components.Layout do
  use Phoenix.Component
  import Components.Core

  def layout(assigns) do
    ~H"""
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1" />
          <title>
            <%= assigns[:page_title] || "Jason Stiebs" %>
          </title>
          <link rel="preconnect" href="https://fonts.googleapis.com">
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
          <link href="https://fonts.googleapis.com/css2?family=Fira+Mono:wght@400;500&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
          <link rel="stylesheet" href="/assets/app.css">
          <link rel="icon" type="image/png" sizes="32x32" href="/assets/favicon-32x32.png">
          <link rel="icon" type="image/png" sizes="16x16" href="/assets/favicon-16x16.png">
        </head>
        <body>
          <header class="site-header">
            <.a href="/" class="site-name">Jason Stiebs</.a>
            <nav aria-label="Main navigation">
              <.a href="/">Writing</.a>
              <.a href="/about">About</.a>
            </nav>
          </header>
          <main>
            <%= render_slot(@inner_block) %>
          </main>
          <footer class="site-footer">
            <p>© <%= DateTime.utc_now.year %> Jason Stiebs</p>
          </footer>
        </body>
      </html>
    """
  end
end
