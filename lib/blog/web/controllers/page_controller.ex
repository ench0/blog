defmodule Blog.Web.PageController do
  use Blog.Web, :controller

  alias Blog.Base
  alias Blog.Org

  def index(conn, _params) do
    pages = Base.list_pages()
    posts = Base.list_posts()
    about = Base.about()
    tags = Org.list_tags()
    render(conn, "index.html", pages: pages, posts: posts, about: about, tags: tags)
  end

  def new(conn, params) do
    changeset = Base.change_page(%Blog.Base.Page{})
    render(conn, "new.html", changeset: changeset, params: params)
  end

  def create(conn, %{"page" => page_params}) do
    case Base.create_page(page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: page_path(conn, :show, page.slug))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, params: page_params)
    end
  end

  def show(conn, %{"slug" => slug}) do
    page = Base.get_page_by(slug)

    case page do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html")
      _ ->
        [intro, body] = Blog.ParsingHelper.split_text(false, page.body)
        # readtime = Blog.ParsingHelper.word_count(intro, body)
        render(conn, "show.html", page: page, intro: intro, body: body)
    end

  end

  def edit(conn, %{"id" => id}) do
    page = Base.get_page(id)
    case page do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html")
      _ ->
        changeset = Base.change_page(page)
        render(conn, "edit.html", page: page, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Base.get_page!(id)

    case Base.update_page(page, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: page_path(conn, :show, page.slug))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Base.get_page!(id)
    {:ok, _page} = Base.delete_page(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
