defmodule Blog.Web.TagController do
  use Blog.Web, :controller

  alias Blog.Org

  def index(conn, _params) do
    tags = Org.list_tags()
    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Org.change_tag(%Blog.Org.Tag{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Org.create_tag(tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: tag_path(conn, :show, tag.slug))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    tag = Org.get_tag_by(slug)

    case tag do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html")
      _ ->
        posts = Enum.map tag.posts, fn(x) ->
          if x.active do
            [x.title,
            #  Blog.ParsingHelper.truncate(x.body, max_length: 300, omission: "..."),
            Enum.at(Blog.ParsingHelper.split_text(false, x.body), 0),
            x.slug,
            Enum.at(x.images, 0),
            x.inserted_at
            ]
          end
        end
        render(conn, "show.html", tag: tag, posts: posts)
    end
  end

  def edit(conn, %{"id" => id}) do
    tag = Org.get_tag(id)
    case tag do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html", tag: tag)
      _ ->
        changeset = Org.change_tag(tag)
        render(conn, "edit.html", tag: tag, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Org.get_tag!(id)

    case Org.update_tag(tag, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: tag_path(conn, :show, tag.slug))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag: tag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Org.get_tag!(id)
    {:ok, _tag} = Org.delete_tag(tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: tag_path(conn, :index))
  end
end
