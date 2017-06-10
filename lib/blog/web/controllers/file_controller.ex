defmodule Blog.Web.FileController do
  use Blog.Web, :controller

  alias Blog.Comp
  alias Blog.Base

  def index(conn, _params) do
    files = Comp.list_files()
    render(conn, "index.html", files: files)
  end

  def new(conn, %{"post_id" => post_id, "page_id" => page_id}) do
    posts = Base.list_posts()
    pages = Base.list_pages()

    changeset = Comp.change_file(%Blog.Comp.File{})
    render(conn, "new.html", changeset: changeset, posts: posts, pages: pages, post_id: post_id, page_id: page_id)
  end

  # def new(conn, _params) do
  #   changeset = Comp.change_file(%Blog.Comp.File{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"file" => file_params, "post_id" => post_id, "page_id" => page_id}) do
    file = file_params["file"]   
    posts = Base.list_posts()
    pages = Base.list_pages()

    case Comp.create_file(file_params) do
      {:ok, file} ->
        IO.puts "ok?"
          IO.puts "+++"
          IO.inspect Blog.ParsingHelper.is_numeric post_id
          IO.inspect Blog.ParsingHelper.is_numeric page_id
        # if post_id != "" do redirect = post_path(conn, :edit, post_id) end
        # if page_id != "" do redirect = page_path(conn, :edit, page_id) end
        if Blog.ParsingHelper.is_numeric post_id do
          conn
          |> put_flash(:info, "File created successfully.")
          |> redirect(to: post_path(conn, :edit, post_id))
          # |> redirect(to: file_path(conn, :show, file))
          # |> redirect(to: redirect)
        end
        if Blog.ParsingHelper.is_numeric page_id do
          conn
          |> put_flash(:info, "File created successfully.")
          |> redirect(to: page_path(conn, :edit, page_id))
          # |> redirect(to: file_path(conn, :show, file))
          # |> redirect(to: redirect)
        end
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "not ok"
        render(conn, "new.html", changeset: changeset, posts: posts, pages: pages, post_id: post_id, page_id: page_id)
    end
  end

  def show(conn, %{"id" => id}) do
    file = Comp.get_file!(id)
    render(conn, "show.html", file: file)
  end

  def edit(conn, %{"id" => id}) do
    file = Comp.get_file(id)
    case file do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html")
      _ ->
        post_id = file.post_id
        page_id = file.page_id
        changeset = Comp.change_file(file)
        render(conn, "edit.html", file: file, changeset: changeset, post_id: post_id, page_id: page_id)
    end
  end

  def update(conn, %{"id" => id, "file" => file_params}) do
    file = Comp.get_file!(id)

    case Comp.update_file(file, file_params) do
      {:ok, file} ->
        conn
        |> put_flash(:info, "File updated successfully.")
        |> redirect(to: file_path(conn, :show, file))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", file: file, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    file = Comp.get_file!(id)
    post_id = file.post_id
    page_id = file.page_id
    
    {:ok, _file} = Comp.delete_file(file)

    if post_id do
      conn
      |> put_flash(:info, "File deleted successfully.")
      |> redirect(to: post_path(conn, :edit, post_id))
    end
    if page_id do
      conn
      |> put_flash(:info, "File deleted successfully.")
      |> redirect(to: page_path(conn, :edit, page_id))
    end
  end
end
