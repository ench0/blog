defmodule Blog.Web.ImageController do
  use Blog.Web, :controller

  alias Blog.Comp
  alias Blog.Base

  def index(conn, _params) do
    images = Comp.list_images()
    render(conn, "index.html", images: images)
  end

  def new(conn, %{"post_id" => post_id, "page_id" => page_id}) do
    posts = Base.list_posts()
    pages = Base.list_pages()

    changeset = Comp.change_image(%Blog.Comp.Image{})
    render(conn, "new.html", changeset: changeset, posts: posts, pages: pages, post_id: post_id, page_id: page_id)
  end

  # def new(conn, _params) do
  #   changeset = Comp.change_image(%Blog.Comp.Image{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"image" => image_params, "post_id" => post_id, "page_id" => page_id}) do
    image = image_params["image"]   
    posts = Base.list_posts()
    pages = Base.list_pages()

    case Comp.create_image(image_params) do
      {:ok, image} ->
        IO.puts "ok?"
          IO.puts "+++"
          IO.inspect Blog.ParsingHelper.is_numeric post_id
          IO.inspect Blog.ParsingHelper.is_numeric page_id
        # if post_id != "" do redirect = post_path(conn, :edit, post_id) end
        # if page_id != "" do redirect = page_path(conn, :edit, page_id) end
        if Blog.ParsingHelper.is_numeric post_id do
          conn
          |> put_flash(:info, "Image created successfully.")
          |> redirect(to: post_path(conn, :edit, post_id))
          # |> redirect(to: image_path(conn, :show, image))
          # |> redirect(to: redirect)
        end
        if Blog.ParsingHelper.is_numeric page_id do
          conn
          |> put_flash(:info, "Image created successfully.")
          |> redirect(to: page_path(conn, :edit, page_id))
          # |> redirect(to: image_path(conn, :show, image))
          # |> redirect(to: redirect)
        end
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "not ok"
        render(conn, "new.html", changeset: changeset, posts: posts, pages: pages, post_id: post_id, page_id: page_id)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Comp.get_image!(id)
    render(conn, "show.html", image: image)
  end

  def edit(conn, %{"id" => id}) do
    image = Comp.get_image(id)
    case image do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html")
      _ ->
        post_id = image.post_id
        page_id = image.page_id
        changeset = Comp.change_image(image)
        render(conn, "edit.html", image: image, changeset: changeset, post_id: post_id, page_id: page_id)
    end
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Comp.get_image!(id)

    case Comp.update_image(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: image_path(conn, :show, image))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Comp.get_image!(id)
    post_id = image.post_id
    page_id = image.page_id
    
    {:ok, _image} = Comp.delete_image(image)

    if post_id do
      conn
      |> put_flash(:info, "Image deleted successfully.")
      |> redirect(to: post_path(conn, :edit, post_id))
    end
    if page_id do
      conn
      |> put_flash(:info, "Image deleted successfully.")
      |> redirect(to: page_path(conn, :edit, page_id))
    end
  end
end
