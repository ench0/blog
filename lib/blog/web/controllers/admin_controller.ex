defmodule Blog.Web.AdminController do
  use Blog.Web, :controller

  alias Blog.Comp
  alias Blog.Base
  alias Blog.Org

  def index(conn, _params) do
    # forms = Comp.list_forms()
    IO.inspect conn.params["path"]
    IO.inspect conn.path_info
    render(conn, "index.html")
  end

  def posts(conn, _params) do
    posts = Base.list_posts_full()
    # IO.puts "!!!"
    # IO.inspect posts
    render(conn, "posts.html", posts: posts)
  end

  def pages(conn, _params) do
    pages = Base.list_pages()
    render(conn, "pages.html", pages: pages)
  end

  def tags(conn, _params) do
    tags = Org.list_tags()
    render(conn, "tags.html", tags: tags)
  end

  def images(conn, _params) do
    images = Comp.list_images()
    render(conn, "images.html", images: images)
  end

  def path(conn, _params) do
    render(conn, Blog.Web.LayoutView, "404.html")
  end

end
