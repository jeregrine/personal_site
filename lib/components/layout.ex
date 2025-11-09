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
        <body class="antialiased bg-[#1f2430] text-[#cbccc6] min-h-screen">
        <div class="mb-0 mx-auto pt-6 px-0 pb-12">
          <header class="wrap mt-0 mx-auto mb-8">
            <div class="tui-border border-[#5ccfe6] mb-6">
              <div class="flex items-center justify-between py-3 px-4">
                <div class="flex items-center gap-4">
                  <.a href="/" class="font-bold text-[#ffcc66] hover:text-[#ffd580] text-lg font-mono">
                    Jason Stiebs
                  </.a>
                  <span :if={assigns[:category]} class="text-[#5ccfe6]">
                    <span class="text-[#707a8c]">│</span>
                    <.a href="/" class="text-[#5ccfe6] hover:text-[#73d0ff]"><%= assigns[:category] %></.a>
                  </span>
                </div>
                <div class="flex items-center gap-4">
                  <.a href={"/about"} class="text-[#95e6cb] hover:text-[#aaffd7] font-mono text-sm">
                    about
                  </.a>
                </div>
              </div>
            </div>
          </header>
          <main class="wrap mx-auto">
            <%= render_slot(@inner_block) %>
          </main>
        </div>
        </body>
      </html>
    """
  end
end
