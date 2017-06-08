defmodule Blog.Web.Router do
  use Blog.Web, :router
  import Blog.PlugHelper

  pipeline :browser do
    plug :timer_start
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :timer_end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/posts", Blog.Web do
    pipe_through :browser

    resources "/", PostController, only: [:index]
    get "/:slug", PostController, :show
  end

  scope "/tags", Blog.Web do
    pipe_through :browser

    resources "/", TagController, only: [:index]
    get "/:slug", TagController, :show
  end

  scope "/images", Blog.Web do
    pipe_through :browser

    resources "/", ImageController, only: [:index, :show]
  end

  scope "/admin", Blog.Web do
    pipe_through :browser

    resources "/", AdminController,  only: [:index]

    get "/posts", AdminController, :posts
    resources "/posts", PostController, except: [:index, :show]

    get "/pages", AdminController, :pages
    resources "/pages", PageController, except: [:index, :show]

    get "/tags", AdminController, :tags
    resources "/tags", TagController, except: [:index, :show]

    get "/images", AdminController, :images
    resources "/images", ImageController, except: [:index, :show]
  end


  scope "/", Blog.Web do
    pipe_through :browser # Use the default browser stack

    resources "/", PageController, only: [:index]
    get "/:slug", PageController, :show
    get "/*path", AdminController, :path
  end



  # Other scopes may use custom stacks.
  # scope "/api", Blog.Web do
  #   pipe_through :api
  # end
  
  if Mix.env == :dev do
    scope "/dev" do
      pipe_through [:browser]

      forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/dev/mailbox"]
    end
  end
end
