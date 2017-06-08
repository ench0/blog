defmodule Blog.Web.PostController do
  use Blog.Web, :controller

  alias Blog.Base

  def index(conn, _params) do
    posts = Base.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, params) do
    changeset = Base.change_post(%Blog.Base.Post{})
    tags= ""
    render(conn, "new.html", changeset: changeset, tags: tags, params: params)
  end

  def create(conn, %{"post" => post_params}) do
    tags = post_params["tags"]
    IO.puts "tags"
    IO.inspect tags
    case Base.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :edit, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, tags: tags)
    end
  end

  def show(conn, %{"slug" => slug}) do
    post = Base.get_post_by(slug)
    case post do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html", post: post)
      _ ->
        [intro, body] = Blog.ParsingHelper.split_text(false, post.body)
        readtime = Blog.ParsingHelper.word_count(intro, body)
        render(conn, "show.html", post: post, intro: intro, body: body, readtime: readtime)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Base.get_post(id)

    case post do
      nil ->
        render(conn, Blog.Web.LayoutView, "404.html", post: post)
      _ ->
        tags = Enum.join(Enum.map(post.tags, &(&1.name)), ",")
        # IO.inspect tags
        changeset = Base.change_post(post)
        render(conn, "edit.html", post: post, changeset: changeset, tags: tags, conn: conn, post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Base.get_post!(id)
    tags = Enum.join(Enum.map(post.tags, &(&1.name)), ",")

    case Base.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post.slug))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset, tags: tags)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Base.get_post!(id)
    {:ok, _post} = Base.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
