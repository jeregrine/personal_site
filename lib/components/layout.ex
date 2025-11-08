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
          <link rel="preconnect" href="https://rsms.me/">
          <link rel="stylesheet" href="https://rsms.me/inter/inter.css">
          <link rel="stylesheet" href="/assets/app.css">
        </head>
        <body class="antialiased bg-gradient-to-t to-sky-50 from-neutral-50">
        <div class="mb-0 mx-auto pt-3 px-0 pb-12">
          <header class="wrap mt-0 mx-auto mb-8 text-stone">
            <div class="flex items-center justify-between py-3">
              <div class="flex items-center gap-4">
                <.a href="/" class="font-black text-md">
                  Jason Stiebs
                </.a>
                <span :if={assigns[:category]} class="text-stone-400">
                  <span class="text-stone-200">/</span>
                  <.a href="/"><%= assigns[:category] %></.a>
                </span>
              </div>
              <div class="flex items-center gap-4">
                <.a href={"/about"} class="text-stone-500">
                  About
                </.a>
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
