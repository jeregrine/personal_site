defmodule Components.Layout do
  use Phoenix.Component
  import Components.Core

  def layout(assigns) do
    ~H"""
      <!DOCTYPE html>
      <html lang="en" class="[scrollbar-gutter:stable]">
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1" />
          <title>
            <%= assigns[:page_title] || "Jason Stiebs" %>
          </title>
          <link rel="preconnect" href="https://fonts.googleapis.com">
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
          <link href="https://fonts.googleapis.com/css2?family=Fira+Mono:wght@400;500;700&display=swap" rel="stylesheet">
          <link rel="stylesheet" href="/assets/app.css">
          <link rel="icon" type="image/png" sizes="32x32" href="/assets/favicon-32x32.png">
          <link rel="icon" type="image/png" sizes="16x16" href="/assets/favicon-16x16.png">
        </head>
        <body class="antialiased bg-[#FAF7F2] text-[#2D2926] min-h-screen">
          <!-- Subtle geometric accents -->
          <div class="geometric-accent geometric-accent-tr"></div>
          <div class="geometric-accent geometric-accent-bl"></div>

          <div class="relative z-10 mb-0 mx-auto pt-8 px-0 pb-12">
            <header class="wrap mt-0 mx-auto mb-10">
              <div class="flex items-baseline justify-between border-b border-[#D4CFC7] pb-4">
                <.a href="/" class="group">
                  <span class="text-2xl font-medium text-[#1A1A1A] group-hover:text-[#8B6914] transition-colors">
                    Jason Stiebs
                  </span>
                </.a>
                <nav class="flex items-center gap-6 font-mono text-sm">
                  <.a href="/" class="text-[#6B6560] hover:text-[#B8860B] transition-colors">
                    writing
                  </.a>
                  <.a href={"/about"} class="text-[#6B6560] hover:text-[#B8860B] transition-colors">
                    about
                  </.a>
                </nav>
              </div>
            </header>
            <main class="wrap mx-auto">
              <%= render_slot(@inner_block) %>
            </main>
            <footer class="wrap mx-auto mt-12 pt-6 border-t border-[#D4CFC7]">
              <p class="text-xs text-[#8B8580] font-mono">
                © <%= DateTime.utc_now.year %>
              </p>
            </footer>
          </div>
        </body>
      </html>
    """
  end
end
